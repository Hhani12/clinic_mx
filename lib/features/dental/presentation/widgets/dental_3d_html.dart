/// Generates self-contained HTML/CSS/JS for the interactive 3D dental chart.
///
/// Uses Three.js to render a GLB model where each tooth is a separate mesh
/// named by FDI number (11-18, 21-28, 31-38, 41-48). Real raycasting
/// detects exactly which tooth mesh the user clicked.
///
/// Communication:
///   JS -> Flutter:  postMessage (works for both WebView2 and iframe)
///   Flutter -> JS:  window.updateDentalState(json)
library;

/// Builds the full HTML string for the 3D dental viewer.
///
/// [modelUrl] is a URL (http, https, or virtual-host) pointing to the GLB file.
/// The model is fetched by GLTFLoader at runtime, avoiding the 2MB
/// `NavigateToString` limit in WebView2 and large `srcdoc` on web.
String buildDental3DHtml({required String modelUrl}) {
  return '''
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<style>
  * { margin:0; padding:0; box-sizing:border-box; }
  html, body { width:100%; height:100%; overflow:hidden; background:#0D1117; }
  canvas { display:block; width:100%; height:100%; }
  #tooltip {
    position:absolute; display:none; pointer-events:none;
    padding:4px 10px; border-radius:8px;
    background:rgba(0,0,0,0.75); border:1px solid rgba(0,229,255,0.3);
    color:#fff; font:bold 12px 'Segoe UI',sans-serif;
    backdrop-filter:blur(6px); z-index:20;
    transform:translate(-50%,-130%);
  }
  #loading {
    position:absolute; top:50%; left:50%; transform:translate(-50%,-50%);
    color:rgba(255,255,255,0.5); font:14px 'Segoe UI',sans-serif;
    z-index:30;
  }
</style>
</head>
<body>
<div id="loading">Loading 3D Model...</div>
<div id="tooltip"></div>

<script type="importmap">
{
  "imports": {
    "three": "https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js",
    "three/addons/": "https://cdn.jsdelivr.net/npm/three@0.160.0/examples/jsm/"
  }
}
</script>
<script type="module">
import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

// ========== State ==========
let selectedTeeth = new Set();   // Set of universal numbers
let toothStatuses = {};          // FDI string -> status string
let procedureCounts = {};        // FDI string -> int
let numberingSystem = 'fdi';
let hoveredFdi = null;

// ========== FDI <-> Universal mapping ==========
const FDI_TO_UNIVERSAL = {};
const UNIVERSAL_TO_FDI = {
  1:'18',2:'17',3:'16',4:'15',5:'14',6:'13',7:'12',8:'11',
  9:'21',10:'22',11:'23',12:'24',13:'25',14:'26',15:'27',16:'28',
  17:'38',18:'37',19:'36',20:'35',21:'34',22:'33',23:'32',24:'31',
  25:'41',26:'42',27:'43',28:'44',29:'45',30:'46',31:'47',32:'48',
};
for (const [u, fdi] of Object.entries(UNIVERSAL_TO_FDI)) {
  FDI_TO_UNIVERSAL[fdi] = parseInt(u);
}

// Valid FDI names from the model
const VALID_FDI = new Set(Object.values(UNIVERSAL_TO_FDI));

// ========== Status colors (hex) ==========
const STATUS_HEX = {
  healthy:    0xF5F0E8,
  filled:     0x4FC3F7,
  extracted:  0xEF5350,
  root_canal: 0xAB47BC,
  crowned:    0xFFB74D,
  braces:     0x7E57C2,
  treated:    0x66BB6A,
  decayed:    0xFF7043,
  missing:    0x9E9E9E,
};

const SELECTED_COLOR = 0x00E5FF;
const HOVER_COLOR    = 0x40E0FF;
const DEFAULT_TOOTH  = 0xF5F0E8;
const GUM_COLOR      = 0xD4636F;

// ========== Scene ==========
const scene = new THREE.Scene();
scene.background = new THREE.Color(0x0D1117);

const camera = new THREE.PerspectiveCamera(
  40, window.innerWidth / window.innerHeight, 0.1, 100
);
camera.position.set(0, 0.5, 6);

const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
renderer.toneMapping = THREE.ACESFilmicToneMapping;
renderer.toneMappingExposure = 1.2;
document.body.appendChild(renderer.domElement);

// ========== Lighting ==========
scene.add(new THREE.AmbientLight(0xffffff, 0.6));

const mainLight = new THREE.DirectionalLight(0xffffff, 1.2);
mainLight.position.set(2, 4, 5);
scene.add(mainLight);

const fillLight = new THREE.DirectionalLight(0x8ecae6, 0.4);
fillLight.position.set(-3, 2, -2);
scene.add(fillLight);

const rimLight = new THREE.DirectionalLight(0x00E5FF, 0.3);
rimLight.position.set(0, -2, -4);
scene.add(rimLight);

// ========== Controls ==========
const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;
controls.dampingFactor = 0.08;
controls.minDistance = 3;
controls.maxDistance = 12;
controls.maxPolarAngle = Math.PI * 0.75;
controls.minPolarAngle = Math.PI * 0.25;
controls.target.set(0, 0.3, 0);
controls.update();

// ========== Raycaster ==========
const raycaster = new THREE.Raycaster();
const mouse = new THREE.Vector2();
const toothMeshes = [];       // Array of Mesh — only tooth meshes
const toothMeshMap = {};      // FDI string -> Mesh
const originalMaterials = {}; // FDI string -> original Material clone
const tooltip = document.getElementById('tooltip');

// ========== Load GLB from URL ==========
const modelUrl = "$modelUrl";

new GLTFLoader().load(modelUrl, (gltf) => {
  const model = gltf.scene;

  // Center and scale
  const box = new THREE.Box3().setFromObject(model);
  const center = box.getCenter(new THREE.Vector3());
  const size = box.getSize(new THREE.Vector3());
  const maxDim = Math.max(size.x, size.y, size.z);
  const scale = 3.0 / maxDim;
  model.scale.setScalar(scale);
  model.position.sub(center.multiplyScalar(scale));

  // Traverse and index tooth meshes
  model.traverse((child) => {
    if (!child.isMesh) return;

    const name = child.name.trim();

    // Check if this node's name is a valid FDI number
    // Node names in the model: "11","12",...,"48" and "Gums_GumsMaterial_0"
    // Also check parent node name
    const parentName = child.parent ? child.parent.name.trim() : '';
    const fdi = VALID_FDI.has(name) ? name
              : VALID_FDI.has(parentName) ? parentName
              : null;

    if (fdi) {
      // Tooth mesh — make material unique (clone) for per-tooth coloring
      child.material = child.material.clone();
      child.material.roughness = 0.3;
      child.material.metalness = 0.05;
      child.material.color.setHex(DEFAULT_TOOTH);

      toothMeshes.push(child);
      toothMeshMap[fdi] = child;
      originalMaterials[fdi] = child.material.clone();

      // Store FDI on the mesh for raycasting lookup
      child.userData.fdi = fdi;
      child.userData.universal = FDI_TO_UNIVERSAL[fdi];
    } else if (name.toLowerCase().includes('gum')) {
      // Gum mesh
      child.material = child.material.clone();
      child.material.color.setHex(GUM_COLOR);
      child.material.roughness = 0.6;
      child.material.metalness = 0.02;
    }
  });

  scene.add(model);
  document.getElementById('loading').style.display = 'none';

  // Apply any pending state
  applyVisualState();
  postToFlutter({ type: 'ready' });

}, (progress) => {
  if (progress.total > 0) {
    const pct = Math.round((progress.loaded / progress.total) * 100);
    document.getElementById('loading').textContent = 'Loading 3D Model... ' + pct + '%';
  }
}, (err) => {
  document.getElementById('loading').textContent = 'Error loading model: ' + (err.message || err);
  console.error('GLTFLoader error:', err);
  postToFlutter({ type: 'error', message: String(err.message || err) });
});

// ========== Visual state application ==========
function applyVisualState() {
  for (const [fdi, mesh] of Object.entries(toothMeshMap)) {
    const universal = FDI_TO_UNIVERSAL[fdi];
    const isSelected = selectedTeeth.has(universal);
    const isHovered = hoveredFdi === fdi;
    const status = toothStatuses[fdi] || 'healthy';

    if (isSelected) {
      mesh.material.color.setHex(SELECTED_COLOR);
      mesh.material.emissive = new THREE.Color(SELECTED_COLOR);
      mesh.material.emissiveIntensity = 0.25;
    } else if (isHovered) {
      mesh.material.color.setHex(HOVER_COLOR);
      mesh.material.emissive = new THREE.Color(HOVER_COLOR);
      mesh.material.emissiveIntensity = 0.15;
    } else {
      const hex = STATUS_HEX[status] || DEFAULT_TOOTH;
      mesh.material.color.setHex(hex);
      mesh.material.emissive = new THREE.Color(0x000000);
      mesh.material.emissiveIntensity = 0;
    }
  }
}

// ========== Click handler (raycasting) ==========
let isDragging = false;
let pointerDownPos = { x: 0, y: 0 };
let longPressTimer = null;

renderer.domElement.addEventListener('pointerdown', (e) => {
  pointerDownPos = { x: e.clientX, y: e.clientY };
  isDragging = false;

  // Long press detection
  const fdi = raycastTooth(e);
  if (fdi) {
    longPressTimer = setTimeout(() => {
      const u = FDI_TO_UNIVERSAL[fdi];
      if (u) postToFlutter({ type: 'toothLongPress', universal: u });
      longPressTimer = null;
    }, 500);
  }
});

renderer.domElement.addEventListener('pointermove', (e) => {
  const dx = e.clientX - pointerDownPos.x;
  const dy = e.clientY - pointerDownPos.y;
  if (Math.abs(dx) > 4 || Math.abs(dy) > 4) {
    isDragging = true;
    if (longPressTimer) { clearTimeout(longPressTimer); longPressTimer = null; }
  }

  // Hover
  const fdi = raycastTooth(e);
  if (fdi !== hoveredFdi) {
    hoveredFdi = fdi;
    applyVisualState();
    if (fdi) {
      const u = FDI_TO_UNIVERSAL[fdi];
      postToFlutter({ type: 'toothHover', universal: u });

      // Tooltip
      const label = numberingSystem === 'fdi' ? fdi : (u || fdi);
      tooltip.textContent = label;
      tooltip.style.display = 'block';
      tooltip.style.left = e.clientX + 'px';
      tooltip.style.top = e.clientY + 'px';
    } else {
      postToFlutter({ type: 'toothHoverOut' });
      tooltip.style.display = 'none';
    }
  } else if (fdi) {
    tooltip.style.left = e.clientX + 'px';
    tooltip.style.top = e.clientY + 'px';
  }
});

renderer.domElement.addEventListener('pointerup', (e) => {
  if (longPressTimer) { clearTimeout(longPressTimer); longPressTimer = null; }
  if (isDragging) return; // Ignore clicks that were actually drags

  const fdi = raycastTooth(e);
  if (fdi) {
    const u = FDI_TO_UNIVERSAL[fdi];
    if (u) postToFlutter({ type: 'toothTap', universal: u });
  }
});

renderer.domElement.addEventListener('pointerleave', () => {
  if (longPressTimer) { clearTimeout(longPressTimer); longPressTimer = null; }
  if (hoveredFdi) {
    hoveredFdi = null;
    applyVisualState();
    tooltip.style.display = 'none';
    postToFlutter({ type: 'toothHoverOut' });
  }
});

function raycastTooth(event) {
  mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
  mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;
  raycaster.setFromCamera(mouse, camera);
  const hits = raycaster.intersectObjects(toothMeshes, false);
  if (hits.length > 0) {
    const mesh = hits[0].object;
    return mesh.userData.fdi || null;
  }
  return null;
}

// ========== Animation loop ==========
function animate() {
  requestAnimationFrame(animate);
  controls.update();
  renderer.render(scene, camera);
}
animate();

// ========== Resize ==========
window.addEventListener('resize', () => {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
});

// ========== Flutter communication ==========
function postToFlutter(data) {
  try {
    const json = JSON.stringify(data);
    if (window.chrome && window.chrome.webview) {
      window.chrome.webview.postMessage(json);
    } else if (window.parent !== window) {
      window.parent.postMessage(json, '*');
    }
  } catch(e) { console.error('postToFlutter:', e); }
}

// Called from Flutter to update state
window.updateDentalState = function(stateJson) {
  try {
    const state = typeof stateJson === 'string' ? JSON.parse(stateJson) : stateJson;
    if (state.selectedTeeth) selectedTeeth = new Set(state.selectedTeeth);
    if (state.toothStatuses) toothStatuses = state.toothStatuses;
    if (state.procedureCounts) procedureCounts = state.procedureCounts;
    if (state.numberingSystem) numberingSystem = state.numberingSystem;
    applyVisualState();
  } catch(e) { console.error('updateDentalState:', e); }
};

</script>
</body>
</html>
''';
}
