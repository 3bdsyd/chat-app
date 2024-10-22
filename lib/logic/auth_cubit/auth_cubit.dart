import 'package:chat_app/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Controllers
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();

  AuthCubit() : super(AuthInitial());

  // Method to handle visibility change for password fields
  bool isVisibility = false;
  void toggleVisibility() {
    isVisibility = !isVisibility;
    emit(AuthVisibilityChanged(isVisibility));
  }

  // Sign Up with Email
  void signUpWithEmail({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
      // Get.offAllNamed('/homeScreen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
            AuthFailure(message: 'The account already exists for that email.'));
      } else {
        emit(AuthFailure(message: e.toString()));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  // Sign In with Email
  void signInWithEmail(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // boxLogin.write('loginKey', true);
      emit(AuthSuccess());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure(message: 'Wrong password provided.'));
      } else {
        emit(AuthFailure(message: e.toString()));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  // Sign Out
  void signOut() async {
    // boxLogin.write('loginKey', false);
    await firebaseAuth.signOut();
    emit(AuthSignedOut());
    // Get.toNamed('/loginScreen');
  }
}
