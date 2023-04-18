import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/utils/colors.dart';

class propertys extends StatelessWidget {
  const propertys({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return SafeArea(
            child: Scaffold(
          body: ListView.builder(
            itemCount: appCubit.propertyList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                appCubit.propertyList[index].address,
              ),
              subtitle: Text(appCubit.propertyList[index].propertyType),
              trailing: Text(appCubit.propertyList[index].cost.toString()),
              leading: const Icon(Icons.location_on),
              hoverColor: AppColors.mainGreyColor,
            ),
          ),
        ));
      },
    );
  }
}
