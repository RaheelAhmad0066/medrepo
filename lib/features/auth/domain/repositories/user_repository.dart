import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  /// Attempts to authenticate the user using email and password.
  Future<ApiResult<User>> login(String email, String password);

  /// Logs out the user and clears all cached tokens and session state.
  Future<ApiResult<void>> logout();

  /// Retrieves the locally stored user profile if offline.
  Future<ApiResult<User?>> getCachedProfile();
}
