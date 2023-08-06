
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        "email",
        "https://www.googleapis.com/auth/contacts.readonly"
      ]
  );

  Future<GoogleSignIn?> getGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      return _googleSignIn;
    }catch (e) {
      print(e);
      return null;
    }
  }

}