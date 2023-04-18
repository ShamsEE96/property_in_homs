import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/admin_property_type_edit_page.dart';
import 'package:property_in_homs/pages/admin_property_type_home_page.dart';

class ApiTestPage extends StatelessWidget {
  const ApiTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Api Test'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      appCubit.getProperty();
                    },
                    child: const Text('Get Property List'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appCubit.getPropertyTypes();
                    },
                    child: const Text('Get Property Types List'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appCubit.getPropertyBooking();
                    },
                    child: const Text('Get Property Booked List'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appCubit.getPropertyTypes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdminPropertyTypeHomePage(),
                          ));
                    },
                    child: const Text('View Property Types'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
