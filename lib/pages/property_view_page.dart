import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/property_edit_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';

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
            actions: [
              if (true) ...[
                IconButton(
                  tooltip: "Edit",
                  onPressed: () {},
                  icon: const Icon(Icons.edit_document),
                )
              ]
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (Column(
                children: [
                  TextFormField(
                    controller: appCubit.addressController,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      label: const Text("Address:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      icon: const Icon(Icons.location_on),
                      iconColor: AppColors.darkNavyColor,
                      labelStyle: TextStyle(
                        color: AppColors.darkNavyColor,
                      ),
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: appCubit.roomCountController,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      label: const Text("Room Count:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      icon: const Icon(Icons.room_preferences_sharp),
                      iconColor: AppColors.darkNavyColor,
                      labelStyle: TextStyle(
                        color: AppColors.darkNavyColor,
                      ),
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: appCubit.spaceController,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      label: const Text("Space:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      icon: const Icon(Icons.calculate),
                      iconColor: AppColors.darkNavyColor,
                      labelStyle: TextStyle(
                        color: AppColors.darkNavyColor,
                      ),
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: appCubit.costController,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: AppColors.darkNavyColor,
                      ),
                      label: const Text("Cost:"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      icon: const Icon(Icons.money),
                      iconColor: AppColors.darkNavyColor,
                    ),
                    readOnly: true,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: ToggleButtons(
                      isSelected: appCubit.selections,
                      onPressed: (newState) {},
                      color: Colors.black,
                      selectedColor: const Color.fromARGB(255, 255, 255, 255),
                      fillColor: Colors.blue,
                      renderBorder: true,
                      borderWidth: 2,
                      borderColor: const Color.fromARGB(181, 31, 29, 29),
                      borderRadius: BorderRadius.circular(30),
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                      children: const [
                        Text("   For Sale   "),
                        Text("  For Rental  "),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          // await appCubit.save();
                          // if (!context.mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditPage()));
                        },
                        child: const Text("Save")),
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
