import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/firebase/firebase_providers.dart';
import '../../core/services/user_data_sync.dart';

/// Provides a [UserDataSync] instance for the currently logged‑in user.
final userDataSyncProvider = Provider<UserDataSync>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  final firestore = ref.watch(firestoreProvider);

  if (userId == null) {
    throw StateError('User not logged in – cannot create UserDataSync');
  }

  return UserDataSync(firestore: firestore, userId: userId);
});
