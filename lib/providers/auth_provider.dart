import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Google Sign-In (optional)
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(context, 'Google Sign-In failed: ${e.message}');
      return null;
    } catch (e) {
      _showErrorSnackBar(context, 'An unexpected error occurred during Google Sign-In.');
      return null;
    }
  }

  // E-Mail Sign-In
  Future<User?> signInWithEmail(BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign-in failed: ${e.message}';
      if (e.code == 'user-not-found') {
        errorMessage = 'Benutzer nicht gefunden. Bitte überprüfe deine E-Mail-Adresse.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Falsches Passwort. Bitte versuche es erneut.';
      }
      _showErrorSnackBar(context, errorMessage);
      return null;
    } catch (e) {
      _showErrorSnackBar(context, 'An unexpected error occurred during sign-in.');
      return null;
    }
  }

  // E-Mail Registration
  Future<User?> registerWithEmail(BuildContext context, String email, String password, String confirmPassword) async {
    try {
      if (password != confirmPassword) {
        _showErrorSnackBar(context, 'Passwörter stimmen nicht überein.');
        return null;
      }
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed: ${e.message}';
      if (e.code == 'weak-password') {
        errorMessage = 'Das Passwort ist zu schwach. Bitte verwende ein stärkeres Passwort.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Diese E-Mail-Adresse wird bereits verwendet.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Ungültige E-Mail-Adresse. Bitte gib eine gültige E-Mail-Adresse ein.';
      }
      _showErrorSnackBar(context, errorMessage);
      return null;
    } catch (e) {
      _showErrorSnackBar(context, 'An unexpected error occurred during registration.');
      return null;
    }
  }

  // Password Reset
  Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent to $email')),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(context, 'Failed to send password reset email: ${e.message}');
    } catch (e) {
      _showErrorSnackBar(context, 'An unexpected error occurred while sending password reset email.');
    }
  }

  // Sign Out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed out successfully')),
      );
    } catch (e) {
      _showErrorSnackBar(context, 'Failed to sign out.');
    }
  }

  // Error Snackbar Helper
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}