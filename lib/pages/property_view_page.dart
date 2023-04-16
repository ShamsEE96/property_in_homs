import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("View Page"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (Column(
                children: [
                  TextFormField(
                    controller: appCubit.addressController,
                    decoration: const InputDecoration(
                      label: Text("Address:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    
                    controller: appCubit.roomCountController,
                    decoration: const InputDecoration(
                      label: Text("Room Count:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: appCubit.spaceController,
                    decoration: const InputDecoration(
                      label: Text("Space:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: appCubit.costController,
                    decoration: const InputDecoration(
                      label: Text("Cost:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              )),
            ),
          ),
        );
      },
    );
  }
}
