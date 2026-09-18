import 'package:doc_doc/signup/sign_up_cubit.dart';
import 'package:doc_doc/signup/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../customs/CustomElevatedButton.dart';
import '../routes/routes.dart';
import '../units.dart';

class Signupview extends StatefulWidget {
  const Signupview({super.key});

  @override
  State<Signupview> createState() => _SignupviewState();
}

class _SignupviewState extends State<Signupview> {
  bool isPasswordVisible = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text('Account created successfully'),
              ),);
            context.go(Routes.login);
          }
          if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          }
        },
    child:  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: Units.getHeight(context: context, widgetheight: 30),
            left: 25,
            right: 25,
            bottom: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.blue.shade500,
                  ),
                ),
              ),
              SizedBox(
                height: Units.getHeight(context: context, widgetheight: 10),
              ),
              Center(
                child: Text(
                  'Sign up now and start exploring all that our\n'
                  'app has to offer. We’re excited to welcome\n'
                  'you to our community!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black38),
                ),
              ),
              Text(
                'Name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Your name',
                  hintStyle: TextStyle(color: Colors.black26),
                  filled: true,
                  fillColor: Color(0xffF5F6F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Email',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black26),
                  filled: true,
                  fillColor: Color(0xffF5F6F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Password',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black26),
                  filled: true,
                  fillColor: Color(0xffF5F6F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Phone Number',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Your number',
                  hintStyle: TextStyle(color: Colors.black26),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🇬🇧', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 5),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black54,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xffF5F6F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Customelevatedbutton(
                buttonTitle: 'Create Account',
                textColor: Colors.white,
                btnColor: Colors.blue.shade500,
                onpressed: () {
                  final cubit = context.read<SignupCubit>();

                  cubit.signup(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    password: passwordController.text,
                    passwordConfirmation: passwordController.text,
                    gender: 0,
                  );
                },
              ),
              SizedBox(height: 22),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.black12)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                  ),

                  Expanded(child: Divider(color: Colors.black12)),
                ],
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.facebook,
                      color: Colors.blue.shade500,
                      size: 25,
                    ),
                  ),
                  SizedBox(width: 25),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(Icons.apple, color: Colors.black, size: 25),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'By logging, you agree to our ',
                    style: TextStyle(fontSize: 10, color: Colors.black38),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: ' and\n'),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.go(Routes.login);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Color(0xff2879F6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
