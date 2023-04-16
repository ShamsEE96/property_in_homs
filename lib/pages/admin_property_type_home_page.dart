import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/admin_property_type_edit_page.dart';

class AdminPropertyTypeHomePage extends StatelessWidget {
  const AdminPropertyTypeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Property Types List"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: appCubit.propertyTypeList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(appCubit.propertyTypeList[index].propertyTypeName,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle:
                    Text("ID: ${appCubit.propertyTypeList[index].objectId}"),
                onTap: () {
                  String? propertyTypeNAME =
                      appCubit.changePropertyTypeNameToIdEvent(
                    appCubit.propertyTypeList[index].propertyTypeName,
                  );
                  // appCubit.propertyTypeList[index].propertyTypeName =
                  //     propertyTypeNAME ?? "";

                  appCubit.fillPropertyTypeDetailsPage(
                      appCubit.propertyTypeList[index]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminPropertyTypeEditPage(),
                      ));
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              appCubit.clearPropertyTypeDetailsPage();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPropertyTypeEditPage(),
                  ));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
