import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/services/firebase/firebase_providers.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../domain/entities/app_user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

final devAdminLoggedInProvider = StateProvider<bool>((ref) => false);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  );
});

final authStateProvider = StreamProvider((ref) {
  final isDev = ref.watch(devAdminLoggedInProvider);
  if (isDev) {
    return Stream.value(
      null,
    ); // Return something that isn't null if we want to bypass redirection
  }
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final currentUserProfileProvider = StreamProvider<AppUserProfile?>((ref) {
  final isDev = ref.watch(devAdminLoggedInProvider);
  if (isDev) {
    return Stream.value(
      const AppUserProfile(
        uid: 'root-admin-uid',
        clinicId: 'root-clinic',
        email: 'hhanii20032@gmail.com',
        displayName: 'Root Administrator',
        role: UserRole.admin,
        isActive: true,
      ),
    );
  }
  return ref.watch(authRepositoryProvider).watchCurrentUserProfile();
});

final currentClinicIdProvider = Provider<String?>((ref) {
  return ref.watch(currentUserProfileProvider).value?.clinicId;
});

final currentUserRoleProvider = Provider<UserRole?>((ref) {
  return ref.watch(currentUserProfileProvider).value?.role;
});

/// Returns the current user's UID, respecting the dev bypass.
final currentUserIdProvider = Provider<String?>((ref) {
  final profile = ref.watch(currentUserProfileProvider).value;
  if (profile != null) return profile.uid;
  return ref.watch(authRepositoryProvider).currentUser?.uid;
});
