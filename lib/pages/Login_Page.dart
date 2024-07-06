import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/Register_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          _isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          _isLoading = false;
        } else if (state is LoginFailure) {
          SnackBarState(context, state.errorMessage, Colors.red);
          _isLoading = false;
        }
      },
      builder: (BuildContext context, AuthState state) {
        return ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.12,
                        ),
                        CircleAvatar(
                          radius: 80,
                          child: Image.asset("assets/images/scholar.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Scholar Chat",
                          style: TextStyle(
                              fontSize: 25,
                              color: kForeignColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Pacifico"),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.12,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Sign In",
                              style:
                                  TextStyle(fontSize: 25, color: kForeignColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: "Email",
                          hint: "Enter Your Email",
                          color: kForeignColor,
                          preIcon: Icons.email_outlined,
                          onchanged: (data) {
                            email = data;
                          },
                          isSecure: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          label: "password",
                          hint: "Enter your password",
                          color: kForeignColor,
                          preIcon: Icons.password_outlined,
                          onchanged: (data) {
                            password = data;
                          },
                          isSecure: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          label: "Sign In",
                          width: double.infinity,
                          height: 45.0,
                          color: kForeignColor,
                          ontap: () async {
                            if (_formkey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email!, password: password!));
                            } else {}
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Don\`t have an account ? ",
                              style: TextStyle(
                                  color: kForeignColor, fontSize: 15)),
                          TextSpan(
                              text: " Register ",
                              style: const TextStyle(
                                color: kForeignColor,
                                fontSize: 17,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, RegisterPage.id);
                                }),
                        ])),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void SnackBarState(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      dismissDirection: DismissDirection.endToStart,
      elevation: .05,
    ));
  }

  Future<void> UserLogin() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
