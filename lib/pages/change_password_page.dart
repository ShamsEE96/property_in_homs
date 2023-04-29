import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/cubits/auth_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/bloc/states/auth_states.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AuthCubit authCubit = AuthCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text("Change Password"),
              ),
              body: Column(
                children: [
                  // TextFormField(
                  //   controller: authCubit.,
                  //   // obscureText: hidePassword,
                  //   decoration: const InputDecoration(
                  //     labelText: "Phone Number",
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "This field is required!";
                  //     }
                  //     // else if (value.length <= 5) {
                  //     //   return AppString.passwordValidation;
                  //     // }
                  //     return null;
                  //   },
                  // ),
                  TextFormField(
                    controller: authCubit.changePasswordController,
                    // obscureText: hidePassword,
                    decoration: const InputDecoration(
                      labelText: "New Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required!";
                      } else if (value.length <= 6) {
                        return "Password too short-must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: authCubit.changePasswordConfirmationController,
                    // obscureText: hidePassword,
                    decoration: const InputDecoration(
                      labelText: "PasswordConfirmation",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required!";
                      }
                      // else if (value.length <= 6) {
                      //   return AppString.passwordValidation;
                      // }
                      return null;
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
