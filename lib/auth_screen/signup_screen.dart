import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Text(
                      'Already have an account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to ICT Hub!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
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
                const SizedBox(height: 30),
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
    );
  }
}
