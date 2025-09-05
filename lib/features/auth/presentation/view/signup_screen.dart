import 'package:blog/core/theme/appPalette.dart';
import 'package:blog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
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
              AuthField(hintText: 'Name', 
              controller: nameController),
              const SizedBox(height: 10),
              AuthField(hintText: 'Email', 
              controller: emailController),
              const SizedBox(height: 10),
              AuthField(hintText: 'Password', 
              controller: passwordController,
              isViewText: true,
              ),
              const SizedBox(height: 20),
              AuthGradientButton(buttonText: 'Sign Up',),
              const SizedBox(height: 15),
              GestureDetector(
                onTap:(){
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
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    );
  }
}
