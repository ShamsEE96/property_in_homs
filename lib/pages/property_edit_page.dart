import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/property_view_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class PropertyEditPage extends StatelessWidget {
  const PropertyEditPage({super.key});

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
            // titleTextStyle: TextStyle(color: AppColors.darkNavyColor),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: appCubit.addressController,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      label: Text("Address:"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("Room Count"),
                  NumberInputWithIncrementDecrement(
                    controller: appCubit.roomCountController,
                    numberFieldDecoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    widgetContainerDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          // color: Colors.amber,
                          width: 1,
                        )),
                    incIconDecoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    separateIcons: true,
                    decIconDecoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    incIconSize: 28,
                    decIconSize: 28,
                    incIcon: Icons.plus_one,
                    decIcon: Icons.exposure_neg_1,
                    incIconColor: Colors.white,
                    decIconColor: Colors.white,
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
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      label: Text("Space"),
                      border: OutlineInputBorder(),
                      hintText: "Only Number (Square Metre)",
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
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      label: Text("Cost"),
                      border: OutlineInputBorder(),
                      hintText: "Only Number",
                    ),
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
                      onPressed: (newState) {
                        appCubit.propretyStateChangedEvent(newState == 0
                            ? PropertyStateEnum.sale
                            : PropertyStateEnum.rental);
                      },
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
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: DropdownButton(
                  //     isExpanded: true,
                  //     value: appCubit.propertyStateEnum.index,
                  //     items: [
                  //       DropdownMenuItem(
                  //         value: PropertyStateEnum.rental.index,
                  //         child: Text(PropertyStateEnum.rental.name),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: PropertyStateEnum.sale.index,
                  //         child: Text(PropertyStateEnum.sale.name),
                  //       ),
                  //     ],
                  //     onChanged: (value) {
                  //       appCubit.propretyStateChangedEvent(
                  //           PropertyStateEnum.values[value ?? 1]);
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          appCubit.saveProperty();
                          // if (!context.mounted) return;
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const PropertyViewPage()));
                        },
                        child: const Text("Save")),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
