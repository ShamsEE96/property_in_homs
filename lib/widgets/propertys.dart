import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/property_view_page.dart';
import 'package:property_in_homs/utils/colors.dart';

class PropertyListWidget extends StatelessWidget {
  const PropertyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: appCubit.propertyList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                appCubit.propertyList[index].address,
              ),
              subtitle: Text(appCubit.propertyList[index].propertyTypeId),
              trailing: Text(appCubit.propertyList[index].cost.toString()),
              leading: const Icon(Icons.location_on),
              hoverColor: AppColors.seconderyBlueColor,
              tileColor: AppColors.mainWhiteColor,
              iconColor: AppColors.darkNavyColor,
              onTap: () {
                appCubit.fillPropertyDetailsPage(appCubit.propertyList[index]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PropertyViewPage(),
                  ),
                );
              },
            ),
          );
        });
  }
}
