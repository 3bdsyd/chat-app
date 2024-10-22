import 'package:chat_app/logic/auth_cubit/auth_cubit.dart';
import 'package:chat_app/utils/colors_utils.dart';
import 'package:chat_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/login_image.png'),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 5,
                          child: Text(
                            TextUtils.login,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 30, top: 30),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 227, 248, 247),
                              Color.fromARGB(255, 129, 221, 198),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 249, 253, 252),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SingleChildScrollView(
                              child: Form(
                                key: keyForm,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NameAndPasswordWidget(
                                      isLoginScreen: true,
                                    ),
                                    SizedBox(height: 40),
                                    ButtonSignInWidget(
                                      isLoginScreen: true,
                                      keyForm: keyForm,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NameAndPasswordWidget extends StatelessWidget {
  const NameAndPasswordWidget({
    super.key,
    required this.isLoginScreen,
  });

  final bool isLoginScreen;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Column(
      children: [
        SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Username',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        FromFieldWidget(
          isEmail: true,
          validator: (value) {
            if (!RegExp(TextUtils.emailValid).hasMatch(value)) {
              return 'Enter a Valid Email Address';
            } else {
              return null;
            }
          },
          controller: isLoginScreen
              ? authCubit.signInEmailController
              : authCubit.signUpEmailController,
          hintText: isLoginScreen ? '' : 'EX: Abdulrahman',
        ),
        SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Password',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        FromFieldWidget(
          isEmail: false,
          validator: (value) {
            if (value.toString().isEmpty ||
                !RegExp(TextUtils.passwordValid).hasMatch(value)) {
              return 'Enter valid password';
            } else {
              return null;
            }
          },
          controller: isLoginScreen
              ? authCubit.signInPasswordController
              : authCubit.signUpPasswordController,
          hintText: isLoginScreen ? '' : 'EX: pa#dd1*23',
        ),
        SizedBox(height: 15),
        isLoginScreen
            ? Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              )
            : Container(),
      ],
    );
  }
}

class ButtonSignInWidget extends StatelessWidget {
  const ButtonSignInWidget({
    super.key,
    required this.isLoginScreen,
    required this.keyForm,
  });

  final bool isLoginScreen;
  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (_) {},
        ),
        Expanded(
          flex: 2,
          child: Text(
            TextUtils.rememberMe,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Expanded(child: Container(), flex: 1),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              if (isLoginScreen) {
                authCubit.signInWithEmail(
                  context,
                  email: authCubit.signInEmailController.text,
                  password: authCubit.signInPasswordController.text,
                );
              } else {
                if (keyForm.currentState!.validate()) {
                  authCubit.signUpWithEmail(
                    email: authCubit.signUpEmailController.text,
                    password: authCubit.signUpPasswordController.text,
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsUtils.backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            child: Text(
              isLoginScreen ? TextUtils.signIn : TextUtils.register,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ],
    );
  }
}

class FromFieldWidget extends StatelessWidget {
  const FromFieldWidget({
    super.key,
    required this.isEmail,
    required this.validator,
    required this.controller,
    required this.hintText,
  });

  final bool isEmail;
  final Function(dynamic value) validator;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : TextInputType.visiblePassword,
          validator: (value) => validator(value),
          style: Theme.of(context).textTheme.labelMedium,
          obscureText: isEmail ? false : !authCubit.isVisibility,
          decoration: InputDecoration(
            suffixIconColor: ColorsUtils.backgroundColor,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            suffixIcon: isEmail
                ? const Text('')
                : IconButton(
                    onPressed: () {
                      authCubit.toggleVisibility();
                    },
                    icon: Icon(
                      authCubit.isVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorsUtils.backgroundColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorsUtils.backgroundColor,
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }
}
