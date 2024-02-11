import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_belal/cubit/auth_cubit.dart';
import 'package:firebase_belal/cubit/auth_state.dart';
import 'package:firebase_belal/screens/home.dart';
import 'package:firebase_belal/widgets/ebutton.dart';
import 'package:firebase_belal/widgets/formfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController phoneNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/back.svg',
                      width: 50,
                    ),
                    iconSize: 50,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome In ICT Hub!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF1E232C),
                      fontSize: 30,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 50),
                  MyFormField(
                    controller: userNameController,
                    label: 'Username',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  MyFormField(
                    controller: emailController,
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  MyFormField(
                    controller: phoneNoController,
                    label: 'Phone Number',
                    textInputType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  MyFormField(
                    controller: passwordController,
                    label: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'Please enter your password';
                      } else if (text.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  MyFormField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    textInputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else if (value != passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                          ),
                        );
                      } else if (state is AuthLoaded) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeLayout(),
                          ),
                              (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      return MyCustomButton(
                        onPressed: () {
                          if (formKey2.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<AuthCubit>()
                                .createUserWithEmailAndPassword(
                              phoneNo: phoneNoController.text,
                              name: userNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        label: 'Sign Up',
                        isLoading: state is AuthLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
