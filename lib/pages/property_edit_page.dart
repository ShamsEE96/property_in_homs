import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/models/property_type_model.dart';
import 'package:property_in_homs/pages/property_view_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:collection/collection.dart';

class PropertyEditPage extends StatelessWidget {
  PropertyEditPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
            backgroundColor: AppColors.mainBlueColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: appCubit.addressController,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        label: Text("Address:"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (currentText) {
                        if (currentText == null) {
                          return "This field is required!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Room Count",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
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
                        color: Color(0xFF576CBC),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      separateIcons: true,
                      decIconDecoration: const BoxDecoration(
                        color: Color(0xFF576CBC),
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
                      validator: (currentText) {
                        if (currentText == null) {
                          return "This field is required!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CheckboxListTile(
                      title: const Text(
                        "With Furniture?",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: appCubit.withFurniture,
                      onChanged: (newValue) {
                        appCubit.withFurnitureChangedEvent(newValue);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.mainBlueColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        // FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^-?\d*.?\d*,?0*?1*?2*?3*?4*?5*?6*?7*?8*?9*'),
                        ),
                      ],

                      controller: appCubit.spaceController,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      // autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        label: Text("Space"),
                        border: OutlineInputBorder(),
                        suffixText: "Square Metre",
                      ),
                      validator: (currentText) {
                        if (currentText == null) {
                          return "This field is required!";
                        }
                        return null;
                      },
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
                      validator: (currentText) {
                        if (currentText == null) {
                          return "This field is required!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: appCubit.selectedType,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text("not selected yet!"),
                          ),
                          for (PropertyTypeModel type
                              in appCubit.propertyTypeList)
                            DropdownMenuItem(
                              value: type,
                              child: Text(type.propertyTypeName),
                            ),
                        ],
                        onChanged: (value) {
                          appCubit.propertyTypeChangedEvent(value!);
                        },
                        dropdownColor: AppColors.mainBlueColor,
                        iconEnabledColor: AppColors.mainBlueColor,
                      ),
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
                        fillColor: AppColors.mainBlueColor,
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
                      height: 80,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          appCubit.saveProperty();
                          if (!context.mounted) return;
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PropertyViewPage()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainBlueColor,
                          // padding: const EdgeInsets.symmetric(
                          //     horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
