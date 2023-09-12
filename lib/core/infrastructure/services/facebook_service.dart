import 'package:eng_shop/core/error/exception.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookService {

  Future<Map<String, dynamic>?> login() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(); // by default we request the email and the public profile

      print(result.message);

      // loginBehavior is only supported for Android devices, for ios it will be ignored
      // final result = await FacebookAuth.instance.login(
      //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      //   loginBehavior: LoginBehavior
      //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
      // );

      if (result.status == LoginStatus.success) {
        // get the user data
        // by default we get the userId, email,name and picture
        final userData = await FacebookAuth.instance.getUserData();
        return userData;
        // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      } else {
        return Future.value(null);
      }
    } catch (e) {
      print(e);
      throw ServiceException();
    }
  }

  Future<void> logOut() async {
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      print(e);
      throw ServiceException();
    }
  }
}
