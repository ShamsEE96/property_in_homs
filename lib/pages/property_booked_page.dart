import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/models/property_model.dart';
import 'package:property_in_homs/pages/property_view_page.dart';

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
                //  PropertyModel test= appCubit.filteredProperty.firstWhere((element) =>
                //       element.objectId ==
                //       appCubit.currentUserPropertyBookingList[index]
                //           .bookedPropertyId);
                //   appCubit.fillPropertyDetailsPage(propertyList)
                // appCubit
                //     .getPropertyIdforBooking(appCubit.selectedPropertyId ?? "");

                PropertyModel? result = appCubit.propertyList.firstWhere(
                    (element) =>
                        element.objectId ==
                        appCubit.currentUserPropertyBookingList[index]
                            .bookedPropertyId);

                if (result != null) {
                  appCubit.fillPropertyDetailsPage(result);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PropertyViewPage(),
                      ));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
