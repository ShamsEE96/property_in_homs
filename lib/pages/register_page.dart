import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/auth_cubit.dart';
import 'package:property_in_homs/bloc/states/auth_states.dart';
import 'package:property_in_homs/components/custom_button.dart';
import 'package:property_in_homs/components/custom_text_field.dart';
import 'package:property_in_homs/pages/login_page.dart';
import 'package:property_in_homs/utils/colors.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit authCubit = AuthCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: AppColors.seconderyBlueColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.darkNavyColor,
                    size: 75,
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Create your account now",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //USERNAME CONTROLLER
                  CustomTextField(
                    myLabelText: "Username",
                    myValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    controller: authCubit.registerUsernameController,
                    fillColor: AppColors.mainWhiteColor,
                  ),
                  const SizedBox(height: 10),
                  //EMAIL CONTROLLER
                  CustomTextField(
                    controller: authCubit.registerEmailController,
                    myLabelText: "Email Address",
                    fillColor: AppColors.mainWhiteColor,
                    myValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  //EMAIL CONTROLLER
                  CustomTextField(
                    controller: authCubit.registerMobileNoController,
                    myLabelText: "Moblie Phone Number",
                    fillColor: AppColors.mainWhiteColor,
                    myValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  //PASSWORD CONTORLLER
                  CustomTextField(
                    myLabelText: "Password",
                    fillColor: AppColors.mainWhiteColor,
                    controller: authCubit.registerPasswordController,
                    myValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      if (value.length < 6) {
                        return "Password too short-must be at least 6 characters";
                      }
                      return null;
                    },
                    obscureText: !authCubit.passwordVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        authCubit.hidePasswordChangedEvent(
                            authCubit.passwordVisible);
                      },
                      icon: authCubit.passwordVisible
                          ? Icon(
                              Icons.visibility,
                              color: AppColors.mainBlueColor,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.mainBlueColor,
                            ),
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    myLabelText: "Confirm Password",
                    fillColor: AppColors.mainWhiteColor,
                    controller: authCubit.registerPassowrdConfirmation,
                    myValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      if (value != authCubit.registerPasswordController.text) {
                        return "The password confirmation does not match";
                      }
                      return null;
                    },
                    obscureText: !authCubit.passwordConfirmationVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        authCubit.hidePasswordConfirmationChangedEvent(
                            authCubit.passwordConfirmationVisible);
                      },
                      icon: authCubit.passwordConfirmationVisible
                          ? Icon(
                              Icons.visibility,
                              color: AppColors.mainBlueColor,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.mainBlueColor,
                            ),
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    myButtonText: "Register",
                    myTextColor: AppColors.mainWhiteColor,
                    backgroundColor: AppColors.darkNavyColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (await authCubit.register()) {
                          if (!context.mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            ModalRoute.withName("/"),
                          );
                        },
                        child: const Text(
                          "Login now",
                          style: TextStyle(
                              color: Color.fromARGB(255, 25, 100, 160),
                              decoration: TextDecoration.underline,
                              fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
