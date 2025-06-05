// user_profile_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/data/model/user_model.dart';
import 'package:medical_scheduler/data/source/data_source/authDataSrc.dart';

class UserProfileViewModel extends StateNotifier<AsyncValue<UserModel>> {
  final AuthDataSource dataSource;

  UserProfileViewModel(this.dataSource) : super(const AsyncLoading());

  Future<void> fetchUserProfile(String token) async {
    try {
      final user = await dataSource.getUserProfile(token); // implement this
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
