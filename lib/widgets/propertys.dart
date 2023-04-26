import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/models/property_type_model.dart';
import 'package:property_in_homs/pages/property_view_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';

class PropertyListWidget extends StatelessWidget {
  const PropertyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);

        appCubit.filteredProperty.addAll(appCubit.propertyList);

        return SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          appCubit.filterChangedEvent(null);
                        },
                        color: AppColors.mainWhiteColor,
                        icon: const Icon(Icons.list)),
                    const Text("All"),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        appCubit.filterChangedEvent(PropertyStateEnum.rental);
                      },
                      color: AppColors.mainWhiteColor,
                      icon: const Icon(Icons.holiday_village),
                    ),
                    const Text("Rental"),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        appCubit.filterChangedEvent(PropertyStateEnum.sale);
                      },
                      color: AppColors.mainWhiteColor,
                      icon: const Icon(Icons.location_city),
                    ),
                    const Text(" Sale"),
                  ],

                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appCubit.filteredProperty.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  appCubit.filteredProperty[index].address,
                ),
                subtitle: Text(appCubit.propertyTypeList
                    .firstWhere(
                      (element) =>
                          element.objectId ==
                          appCubit.filteredProperty[index].propertyTypeId,
                      orElse: () => PropertyTypeModel(
                          objectId: "no Id Found",
                          propertyTypeName: "no Id Found"),
                    )
                    .propertyTypeName),
                trailing:
                    Text(appCubit.filteredProperty[index].cost.toString()),
                leading: const Icon(Icons.location_on),
                iconColor: AppColors.darkNavyColor,
                hoverColor: AppColors.mainGreyColor,
                tileColor: AppColors.mainWhiteColor,
                onTap: () {
                  appCubit.fillPropertyDetailsPage(
                      appCubit.filteredProperty[index]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PropertyViewPage(),
                      ));
                },
              ),
            ),
          ]),
        );
      },
    );
  }
}
