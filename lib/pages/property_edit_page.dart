import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/property_view_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final List<bool> _selections = List.generate(2, (_) => false);
  dynamic asEnumValue(List<dynamic> enumValues, Enum value) {
    try {
      return enumValues.indexOf(value);
    } catch (err) {
      return null;
    }
  }

  // int indexOfEnum =
  //     asEnumValue(PropertyStateEnum.values, PropertyStateEnum.sale);
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: appCubit.roomCountController,
                    decoration: const InputDecoration(
                      label: Text("Room Count"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: appCubit.spaceController,
                    decoration: const InputDecoration(
                      label: Text("Space"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: appCubit.costController,
                    decoration: const InputDecoration(
                      
                      label: Text("Cost"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ToggleButtons(
                    isSelected: _selections,
                    onPressed: (newState) {
                      print("the new srate:  $newState");
                      appCubit.propretyStateChangedEvent(newState == 0
                          ? PropertyStateEnum.rental
                          : PropertyStateEnum.sale);
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
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      isExpanded: true,
                      value: appCubit.propertyStateEnum.index,
                      items: [
                        DropdownMenuItem(
                          value: PropertyStateEnum.rental.index,
                          child: Text(PropertyStateEnum.rental.name),
                        ),
                        DropdownMenuItem(
                          value: PropertyStateEnum.sale.index,
                          child: Text(PropertyStateEnum.sale.name),
                        ),
                      ],
                      onChanged: (value) {
                        appCubit.propretyStateChangedEvent(
                            PropertyStateEnum.values[value ?? 1]);
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // await appCubit.save();
                        // if (!context.mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewPage()));
                      },
                      child: const Text("Save")),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
