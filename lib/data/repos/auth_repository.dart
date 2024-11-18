import 'package:customer_hailing/data/models/auth/email_sign_up_screen.dart';

import '../api/api_client.dart';

class AuthRepository {
  final _apiClient = ApiClient();

  Future<EmailSignUpResponse?> signUp({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.signUp(
      headers: headers,
      requestData: requestData,
    );
  }

}