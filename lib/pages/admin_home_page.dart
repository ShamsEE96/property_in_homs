import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/admin_property_approval_page.dart';
import 'package:property_in_homs/pages/admin_property_type_home_page.dart';
import 'package:property_in_homs/utils/colors.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Admin Control Panel'),
            backgroundColor: AppColors.mainBlueColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 15,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      appCubit.getProperty();
                      appCubit.filteredProperty.clear();
                      appCubit.filteredProperty.addAll(appCubit.propertyList);

                      // appCubit.filteredProperty.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdminPropertyApprovalPage(),
                          ));
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
                    child: const Text('View Property Pending List'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // IconButton(
                //     onPressed: () async {
                //       await AuthCubit.get(context).logout();
                //     },
                //     icon: const Icon(Icons.logout)),
                SizedBox(
                  height: size.height / 15,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      appCubit.getPropertyTypes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdminPropertyTypeHomePage(),
                          ));
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
                    child: const Text('View Property Types'),
                  ),
                ),
                // SizedBox(
                //   height: size.height / 15,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       appCubit.getPropertyTypes();
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const ProfilePage(),
                //           ));
                //     },
                //     child: const Text('Proflie'),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
