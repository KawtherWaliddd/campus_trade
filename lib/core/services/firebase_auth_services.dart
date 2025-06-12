import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/errors/exception.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message: 'The account already exists for that email.',
        );
      } else {
        throw CustomException(
          message: 'An error occurred. Please try again later.',
        );
      }
    } catch (e) {
      throw CustomException(
        message: 'An error occurred. Please try again later.',
      );
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      print(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'Email or passwrd is incorrect ');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'Email or passwrd is incorrect');
      } else if (e.code == 'invalid-credential') {
        throw CustomException(message: 'Email or passwrd is incorrect');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'Poor internet connection');
      } else {
        throw CustomException(
          message: 'Something went wrong please try again later',
        );
      }
    } catch (e) {
      print(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}",
      );

      throw CustomException(
        message: 'Something went wrong please try again later',
      );
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
