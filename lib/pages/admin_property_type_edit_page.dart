import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/components/custom_button.dart';
import 'package:property_in_homs/components/custom_text_field.dart';
import 'package:property_in_homs/utils/colors.dart';

class AdminPropertyTypeEditPage extends StatelessWidget {
  const AdminPropertyTypeEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            title: const Text('Edit Type'),

            backgroundColor: AppColors.mainBlueColor,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Are you sure you want to delete this Type?"),
                      content: const Text("this operation cannot be undone!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                        TextButton(
                          onPressed: () async {
                            await appCubit.deletePropertyType(
                                appCubit.selectedPropertyTypeId!);
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                  // appCubit.deletePropertyType(appCubit.selectedPropertyTypeId!);
                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                tooltip: "Delete",
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  appCubit.selectedPropertyTypeId ?? 'newTypeId',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  myLabelText: 'Property Type Name',
                  controller: appCubit.propertyTypeNameController,
                  fillColor: AppColors.mainWhiteColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  backgroundColor: AppColors.mainNavyColor,
                  myButtonText: 'Save',
                  onPressed: () async {
                    await appCubit.savePropertyType();
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
