import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../customs/CustomElevatedButton.dart';
import '../routes/routes.dart';
import '../units.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  bool isPasswordVisible = false;
  bool rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go(Routes.home);
        }

        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        }
      },
    child:  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: Units.getHeight(
            context: context,
            widgetheight: 80,
          ),
          left: 25,
          right: 25,
          bottom: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Welcome Back!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.blue.shade500,),),),
            SizedBox(
              height: Units.getHeight( context: context,  widgetheight: 10, ),),
            Center(
              child: Text(
                'We are excited to have you back, can’t wait to\n'
                    'see what you have been up to since you last\n'
                    'logged in.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black38,
                  ),),
            ),
            SizedBox(
              height: Units.getHeight(
                context: context,
                widgetheight: 35,),),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,),),
            SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
                filled: true,
                fillColor:  Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: Units.getHeight(
                context: context,
                widgetheight: 18,),),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
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
                    color: Colors.black38,),),),),
            SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                  activeColor: Colors.black54,
                ),
                Text(
                  'Remember me',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,),),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade500,),),),],
            ),
            SizedBox(height: 8),
            Customelevatedbutton(
              buttonTitle: 'Login',textColor: Colors.white,
              btnColor: Colors.blue.shade500,
              onpressed: () {
                final cubit = context.read<LoginCubit>();
                cubit.login(
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.black12,),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Or sign in with',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,),),),
                Expanded(
                  child: Divider(
                    color: Colors.black12,),),],
            ),
            SizedBox(height: 22),
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
                        fontWeight: FontWeight.bold,),),),
                ),
                SizedBox(width: 25),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.facebook,
                    color:Colors.blue.shade600,
                    size: 25,
                  ),
                ),
                SizedBox(width: 25),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.apple,
                    color: Colors.black,
                    size: 25,),),],
            ),
            SizedBox(height: 18),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'By logging, you agree to our ',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black38,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: ' and\n',
                    ),
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
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  context.push(Routes.signup);
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account yet? ',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.blue.shade500,
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
    )
    );
  }
}

