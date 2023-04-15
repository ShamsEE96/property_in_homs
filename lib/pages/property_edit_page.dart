import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final List<bool> _selections = List.generate(2, (_) => false);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Page"),
            titleTextStyle: TextStyle(color: AppColors.darkNavyColor),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: appCubit.addressController,
                    decoration: const InputDecoration(
                      label: Text("Address"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ToggleButtons(
                    isSelected: _selections,
                    onPressed: (newState) {
                      appCubit.propretyStateChangedEvent(
                          newState as PropertyStateEnum);
                      //       for (int i = 0; i < _selections.length; i++) {
                      //   _selections[i] = i == index;
                      // }
                    },
                    color: Colors.black,
                    selectedColor: const Color.fromARGB(255, 255, 255, 255),
                    fillColor: Colors.blue,
                    renderBorder: true,
                    borderWidth: 1,
                    borderColor: const Color.fromARGB(181, 31, 29, 29),
                    borderRadius: BorderRadius.circular(30),
                    children: const [
                      Text("   For Sale   "),
                      Text("  For Rental  "),
                    ],
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     // await appCubit.save();
                  //     // if (!context.mounted) return;
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => ));
                  //   },
                  //   child: const Text("Save")),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
