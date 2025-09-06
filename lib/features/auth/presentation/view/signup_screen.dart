import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/appPalette.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: Modular.get<AuthBloc>(),
        listener: (context, state) {
          if (state is AuthSuccess) {
            showSnackBar(context, 'Sign up successful!');
            // Navigate back to login screen after a short delay
            Future.delayed(const Duration(seconds: 2), () {
              Modular.to.pop();
            });
          } else if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    color: AppPalette.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                AuthField(hintText: 'Name', controller: nameController),
                const SizedBox(height: 10),
                AuthField(hintText: 'Email', controller: emailController),
                const SizedBox(height: 10),
                AuthField(
                  hintText: 'Password',
                  controller: passwordController,
                  isViewText: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  bloc: Modular.get<AuthBloc>(),
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Loader();
                    }
                    return AuthGradientButton(
                      buttonText: 'Sign Up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Modular.get<AuthBloc>().add(
                            AuthSignUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Modular.to.pop();
                    // Modular.to.navigate('/auth/');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an acount?',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: ' Sign In',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppPalette.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
