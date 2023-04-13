import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Admin Control Panel'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
