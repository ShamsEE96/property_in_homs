import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';

class PropertyBookedPage extends StatelessWidget {
  const PropertyBookedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Booked Property List"),
          ),
          body: ListView.builder(
            itemCount: appCubit.currentUserPropertyBookingList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(appCubit
                  .currentUserPropertyBookingList[index].bookedPropertyId),
              subtitle:
                  Text(appCubit.currentUserPropertyBookingList[index].userId),
              onLongPress: () {
                appCubit.readyPropertyList.firstWhere((element) =>
                    element.objectId ==
                    appCubit.currentUserPropertyBookingList[index]
                        .bookedPropertyId);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {

                // },));
              },
            ),
          ),
        );
      },
    );
  }
}
