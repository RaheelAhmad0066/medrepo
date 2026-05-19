import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/auth/domain/repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository _repository;

  SendOtpUseCase(this._repository);

  Future<ApiResult<void>> call(String emailOrPhone, {required bool isPhone}) {
    return _repository.sendOtp(emailOrPhone, isPhone: isPhone);
  }
}
