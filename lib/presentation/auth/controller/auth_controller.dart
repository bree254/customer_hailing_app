import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/auth/email_sign_up_screen.dart';

import '../../../data/repos/auth_repository.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();
  EmailSignUpResponse? _apiResponse;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<EmailSignUpResponse> signUp({required Map<String, String> headers, required Map requestData}) async {
    try {
      _apiResponse = await authRepository.signUp(headers: headers, requestData: requestData);
      return _apiResponse!;
    } catch (e) {
      throw e;
    }
  }
}
