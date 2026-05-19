import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/auth/domain/entities/user.dart';
import 'package:medrep_pro/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<ApiResult<User>> call(String emailOrPhone, String otp, {required bool isPhone}) {
    return _repository.verifyOtp(emailOrPhone, otp, isPhone: isPhone);
  }
}
