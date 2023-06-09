import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/auth_cubit.dart';
import 'package:property_in_homs/bloc/states/auth_states.dart';
import 'package:property_in_homs/components/custom_button.dart';
import 'package:property_in_homs/components/custom_text_field.dart';
import 'package:property_in_homs/pages/property_home_page.dart';
import 'package:property_in_homs/pages/register_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/dio_helper.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();

  // Future<int?> checkPassword(
  //     TextEditingController x, TextEditingController y) async {
  //   try {
  //     var logData = {
  //       'username': x,
  //       'password': y.text,
  //     };
  //     var res = await DioHelper.dio!.get('login', queryParameters: logData);
  //     if (res.statusCode == 101) {
  //       return res.statusCode;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

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
              child: ListView(children: [
                const SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.darkNavyColor,
                  size: 75,
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "WELLCOME BACK",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: authCubit.loginUsernameController,
                  myValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is requiered";
                    }
                    return null;
                  },
                  fillColor: AppColors.mainWhiteColor,
                  myLabelText: "Your Username",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  myLabelText: "Password",
                  controller: authCubit.loginPasswordController,
                  myValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is requiered";
                    }
                    return null;
                    // if (checkPassword(authCubit.loginUsernameController,
                    //         authCubit.loginPasswordController) ==
                    //     101) {
                    //   return "wrong";
                    // }
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      authCubit
                          .hidePasswordChangedEvent(authCubit.passwordVisible);
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
                  obscureText: !authCubit.passwordVisible,
                  fillColor: AppColors.mainWhiteColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    myButtonText: "login",
                    myTextColor: AppColors.mainWhiteColor,
                    backgroundColor: AppColors.darkNavyColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (await authCubit.login()) {
                          if (!context.mounted) return;
                          authCubit.getProfileInfo();
                          authCubit.loadUserInfo();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "dont have an account ? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                            color: Color.fromARGB(255, 25, 100, 160),
                            decoration: TextDecoration.underline,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
