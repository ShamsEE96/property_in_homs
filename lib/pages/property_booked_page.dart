import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/cubits/auth_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/bloc/states/auth_states.dart';
import 'package:property_in_homs/models/property_model.dart';
import 'package:property_in_homs/pages/property_view_page.dart';
import 'package:property_in_homs/utils/colors.dart';

class PropertyBookedPage extends StatelessWidget {
  const PropertyBookedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit authCubit = AuthCubit.get(context);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit appCubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.mainBlueColor,
                title: const Text("My Booked Property List"),
              ),
              body: ListView.builder(
                itemCount: appCubit.currentUserPropertyBookingList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(appCubit.propertyList
                          .firstWhere(
                            (element) =>
                                element.objectId ==
                                appCubit.currentUserPropertyBookingList[index]
                                    .bookedPropertyId,
                            // orElse: () => PropertyModel(
                            //     objectId: "no Id Found",
                            //     propertyTypeName: "no Id Found"),
                          )
                          .address

                      // appCubit
                      //   .currentUserPropertyBookingList[index].bookedPropertyId
                      ),
                  // subtitle:
                  //     Text(appCubit.currentUserPropertyBookingList[index].userId),
                  onTap: () async {
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
                      await authCubit.getPosterUserInfo(result.posterUserId);
                      result.posterUserId = authCubit.posterUserName;
                      // appCubit.
                      appCubit.fillPropertyDetailsPage(result);
                      if (!context.mounted) {
                        return;
                      }
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
      },
    );
  }
}
