# Clinic App - Professional Implementation Roadmap

## Executive Summary

This document outlines the complete implementation plan to make the Clinic management application fully functional with:
- Secure authentication system with login/logout
- Persistent database storage (Firebase Firestore + Local Drift SQLite)
- Real-time synchronization
- Role-based access control
- Complete audit trail for all changes

---

## Current State Analysis

### Technology Stack
| Layer | Technology |
|-------|------------|
| Frontend | Flutter 3.x (Dart) |
| State Management | Flutter Riverpod |
| Navigation | go_router |
| Backend | Firebase (Auth, Firestore, Functions, Storage) |
| Local Database | Drift (SQLite) |
| Platforms | Windows, Android, iOS, Web |

### Existing Features
- Authentication (Email/Password with Firebase Auth)
- Patient Management (CRUD)
- Appointment Scheduling (Calendar view)
- Doctor Management
- Dental Chart & Treatment Plans
- Payment Tracking
- Clinic Settings & Staff Management
- Appointment Reminders (WhatsApp/SMS/Email)

### Identified Gaps
1. Hardcoded admin credentials in source code (security risk)
2. Incomplete offline sync implementation
3. No audit logging for changes
4. No session persistence across app restarts
5. Missing user management UI for admins

---

## Phase 1: Authentication System Overhaul

### 1.1 Secure Authentication Implementation

**Objectives:**
- Remove hardcoded credentials from source code
- Implement secure credential storage for initial admin
- Add email verification flow
- Implement proper session management

**Implementation Steps:**

```
1. Create environment configuration file (.env) for admin credentials
2. Move hardcoded credentials to secure environment variables
3. Implement email verification on signup
4. Add "Remember Me" functionality
5. Implement session timeout with auto-logout
6. Add biometric authentication (fingerprint/face) for mobile
```

**Files to Create/Modify:**
- `.env` - Environment variables (gitignored)
- `lib/core/config/env_config.dart` - Environment configuration loader
- `lib/features/auth/presentation/pages/login_page.dart` - Add remember me toggle
- `lib/features/auth/domain/repositories/auth_repository.dart` - Add session methods

### 1.2 Login/Logout Flow

**Login Flow:**
```
1. User opens app → Check for existing session
2. If no session → Navigate to Login Page
3. User enters credentials → Validate format
4. Call Firebase Auth → On success, fetch user profile
5. Store session token securely (flutter_secure_storage)
6. Navigate to Dashboard based on user role
```

**Logout Flow:**
```
1. User clicks Logout → Clear session token
2. Clear Riverpod state
3. Navigate to Login Page
4. On next login → Fetch latest data from Firestore
```

### 1.3 Default Admin Credentials

**Setup Process:**

1. **Initial Admin Account** (configurable):
   - Email: `admin@clinic.local`
   - Password: Generated on first run, shown to user
   - Role: `admin`

2. **Development Admin** (for testing):
   - Email: `hhanii20032@gmail.com`
   - Password: `Hhani12@`
   - Stored in `.env` file, not source code

---

## Phase 2: Database Architecture

### 2.1 Firestore Collection Structure

```
/users/{uid}
  - uid: string
  - clinicId: string
  - email: string
  - displayName: string
  - role: 'admin' | 'doctor' | 'reception'
  - isActive: boolean
  - createdAt: timestamp
  - lastLoginAt: timestamp

/clinics/{clinicId}
  - clinicId: string
  - name: string
  - address: string
  - phone: string (E.164)
  - email: string
  - subscriptionExpiresAt: timestamp
  - createdAt: timestamp
  - settings: map

/clinics/{clinicId}/patients/{patientId}
  - id: string
  - clinicId: string
  - firstName: string
  - fatherName: string
  - lastName: string
  - displayName: string
  - displayNameLower: string (for search)
  - phoneNumber: string (E.164)
  - dateOfBirth: timestamp?
  - gender: string?
  - address: string?
  - notes: string?
  - createdAt: timestamp
  - updatedAt: timestamp
  - createdBy: string (uid)

/clinics/{clinicId}/appointments/{appointmentId}
  - id: string
  - clinicId: string
  - patientId: string
  - patientName: string
  - patientPhone: string (E.164)
  - doctorId: string
  - doctorName: string
  - startAt: timestamp
  - durationMinutes: int
  - status: 'scheduled' | 'checked_in' | 'in_treatment' | 'completed' | 'no_show' | 'cancelled'
  - notes: string?
  - reminderSent: boolean
  - createdAt: timestamp
  - updatedAt: timestamp
  - createdBy: string (uid)

/clinics/{clinicId}/doctors/{doctorId}
  - id: string
  - clinicId: string
  - fullName: string
  - monthlySalaryIqd: number
  - commissionPercent: number
  - isActive: boolean
  - createdAt: timestamp
  - updatedAt: timestamp

/clinics/{clinicId}/payments/{paymentId}
  - id: string
  - clinicId: string
  - patientId: string
  - patientName: string
  - amount: number
  - paid: number
  - remaining: number
  - method: 'cash' | 'card' | 'transfer'
  - doctorShare: number?
  - doctorId: string?
  - date: timestamp
  - notes: string?
  - createdAt: timestamp
  - createdBy: string (uid)

/clinics/{clinicId}/dentalPlans/{itemId}
  - id: string
  - clinicId: string
  - patientId: string
  - toothId: string
  - numberingSystem: 'fdi' | 'universal'
  - actionLabel: string
  - timestamp: timestamp
  - createdBy: string (uid)

/clinics/{clinicId}/toothRecords/{recordId}
  - patientId: string
  - toothId: string
  - status: string
  - procedures: list
  - updatedAt: timestamp

/clinics/{clinicId}/settings/{docId}
  - clinicName: string
  - address: string
  - phone: string
  - email: string
  - theme: string
  - language: string
  - reminderEnabled: boolean
  - reminderMethod: string
  - whatsappNumber: string?

/clinics/{clinicId}/staff/{staffId}
  - id: string
  - clinicId: string
  - name: string
  - role: string
  - pinCode: string (hashed)
  - isActive: boolean
  - createdAt: timestamp

/clinics/{clinicId}/auditLogs/{logId}
  - id: string
  - clinicId: string
  - action: string
  - entityType: string
  - entityId: string
  - changes: map (before/after)
  - performedBy: string (uid)
  - performedByName: string
  - timestamp: timestamp
```

### 2.2 Local Database (Drift) Schema

The Drift database serves as an offline cache with these tables:

```sql
-- Local patients cache
CREATE TABLE local_patients (
  id TEXT PRIMARY KEY,
  clinic_id TEXT NOT NULL,
  first_name TEXT NOT NULL,
  father_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  display_name TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  sync_status TEXT DEFAULT 'synced',
  last_synced_at INTEGER,
  created_at INTEGER NOT NULL
);

-- Local appointments cache
CREATE TABLE local_appointments (
  id TEXT PRIMARY KEY,
  clinic_id TEXT NOT NULL,
  patient_id TEXT NOT NULL,
  doctor_id TEXT NOT NULL,
  start_at INTEGER NOT NULL,
  duration_minutes INTEGER NOT NULL,
  status TEXT NOT NULL,
  sync_status TEXT DEFAULT 'synced',
  last_synced_at INTEGER,
  created_at INTEGER NOT NULL
);

-- Sync queue for pending mutations
CREATE TABLE sync_queue (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  entity_type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  operation TEXT NOT NULL, -- 'create', 'update', 'delete'
  payload TEXT NOT NULL, -- JSON
  created_at INTEGER NOT NULL,
  retry_count INTEGER DEFAULT 0
);

-- Sync metadata
CREATE TABLE sync_meta (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at INTEGER NOT NULL
);
```

### 2.3 Security Rules Implementation

Firestore Security Rules ensure:
1. Only authenticated users can access data
2. Users can only access their clinic's data
3. Role-based write permissions
4. Data validation on all writes

---

## Phase 3: Offline-First Synchronization

### 3.1 Sync Engine Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Sync Engine                               │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ Mutation     │  │ Change       │  │ Conflict     │       │
│  │ Queue        │  │ Detector     │  │ Resolver     │       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ Local Cache  │  │ Sync         │  │ Error        │       │
│  │ (Drift)      │  │ Scheduler    │  │ Handler      │       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 Sync Flow

**On Data Change:**
```
1. User creates/updates entity
2. Write to local Drift database immediately
3. Add mutation to sync_queue table
4. Trigger sync if online
5. Show optimistic UI update
```

**Sync Process:**
```
1. Check network connectivity
2. Process sync_queue (oldest first)
3. For each mutation:
   a. Apply to Firestore
   b. On success: remove from queue, update local sync timestamp
   c. On failure: increment retry_count, exponential backoff
4. Pull latest changes from Firestore
5. Update local cache with server timestamps
```

**Conflict Resolution Strategy:**
- **Last Write Wins** for simple fields
- **Merge** for array fields (appointments, procedures)
- **User Prompt** for critical conflicts (payment changes)

---

## Phase 4: Audit Logging

### 4.1 Audit Log Implementation

Every create/update/delete operation logs to `auditLogs` collection:

```dart
class AuditLogEntry {
  final String id;
  final String clinicId;
  final String action; // 'create', 'update', 'delete'
  final String entityType; // 'patient', 'appointment', 'payment'
  final String entityId;
  final Map<String, dynamic> changes; // {before, after}
  final String performedBy; // uid
  final String performedByName;
  final DateTime timestamp;
}
```

### 4.2 Audit Log UI (Admin Only)

- View all changes with filters (date range, entity type, user)
- See before/after values for each change
- Export audit log as PDF/CSV

---

## Phase 5: Admin Dashboard

### 5.1 User Management

**Features:**
- List all users in clinic
- Create new user (assign role)
- Edit user details
- Deactivate/activate user
- Reset user password

### 5.2 Clinic Management

**Features:**
- View clinic subscription status
- Renew subscription
- Update clinic information
- Configure reminder settings
- View audit logs

### 5.3 Data Management

**Features:**
- Export all data (backup)
- Import data (restore)
- View storage usage
- Clear cache

---

## Implementation Timeline

| Phase | Tasks | Estimated Time |
|-------|-------|----------------|
| Phase 1 | Authentication Overhaul | 3-4 days |
| Phase 2 | Database Architecture | 2-3 days |
| Phase 3 | Offline Sync | 4-5 days |
| Phase 4 | Audit Logging | 2 days |
| Phase 5 | Admin Dashboard | 3-4 days |

**Total: 14-18 days**

---

## Testing Strategy

### Unit Tests
- Auth repository methods
- Sync engine logic
- Data validators

### Widget Tests
- Login page
- Patient form
- Appointment calendar

### Integration Tests
- Full login → CRUD → logout flow
- Offline → online sync
- Role-based access control

---

## Deployment Checklist

- [ ] Firebase project configured
- [ ] Firestore rules deployed
- [ ] Cloud Functions deployed
- [ ] Environment variables set
- [ ] App signing keys stored
- [ ] Production build tested
- [ ] Backup strategy verified

---

## Security Considerations

1. **Never commit `.env` file** - Contains secrets
2. **Use flutter_secure_storage** for tokens
3. **Validate all inputs** - Both client and server-side
4. **Rate limiting** - On Cloud Functions
5. **Audit all sensitive operations** - Payment changes, user deletions
6. **HTTPS only** - All API calls
7. **Session timeout** - Auto-logout after inactivity

---

## Next Steps

1. Create `.env` file with admin credentials
2. Deploy updated Firestore rules
3. Implement sync engine
4. Build admin dashboard UI
5. Add audit logging to all CRUD operations
6. Test complete flow: login → make changes → logout → login → see changes
