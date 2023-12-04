import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app_irfans/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_app_irfans/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_app_irfans/data/models/requests/register_request_model.dart';
import 'package:flutter_cbt_app_irfans/presentation/auth/bloc/register/register_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../widgets/register_success_dialog.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Email Address',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: usernameController,
            label: 'Username',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: confirmPasswordController,
            label: 'Confirm Password',
            obscureText: true,
          ),
          const SizedBox(height: 24.0),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (state) {
                  AuthLocalDataSource().saveAuthData(state);
                  context.pushReplacement(const LoginPage());
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const RegisterSuccessDialog();
                    },
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      final dataRequest = RegisterRequestModel(
                          name: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation: confirmPasswordController.text);

                      context
                          .read<RegisterBloc>()
                          .add(RegisterEvent.register(dataRequest));
                    },
                    label: 'REGISTER',
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24.0),
          GestureDetector(
            onTap: () {
              context.pushReplacement(const LoginPage());
            },
            child: const Text.rich(
              TextSpan(
                text: 'Already have an account?? ',
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
