
import 'package:google_sign_in/google_sign_in.dart';

import '../../error/exception.dart';


class GoogleService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> getGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      return googleSignInAccount;
    } catch (e) {
      print(e.toString());
      throw ServiceException();
    }
  }

  Future<GoogleSignInAccount?> signOut() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signOut();
      return googleSignInAccount;
    } catch (e) {
      print(e.toString());
      throw ServiceException();
    }
  }

}