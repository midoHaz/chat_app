import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> UserLogin({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      emit(LoginSuccess());
    }on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user-not-found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'something went wrong '));
    }
  }

  Future<void> UserRegister(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user =
      await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        RegisterFailure(errorMessage: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        RegisterFailure(errorMessage: 'The account already exists for that email.');
      }
    } catch (e) {
      RegisterFailure(errorMessage: 'there was an error');

    }
  }

}
