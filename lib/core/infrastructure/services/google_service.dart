
import 'package:google_sign_in/google_sign_in.dart';

import '../../error/exception.dart';


class GoogleService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        "email",
      ]
  );

  Future<GoogleSignInAccount?> getGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      return googleSignInAccount;
    } catch (e) {
      throw ServiceException();
    }
  }

}