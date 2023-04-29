import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/property_view_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/utils/enums/property_approval_enum.dart';

class AdminPropertyApprovalPage extends StatelessWidget {
  const AdminPropertyApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.mainWhiteColor,
          appBar: AppBar(
            // elevation: 0.0,
            backgroundColor: AppColors.mainBlueColor,
            // toolbarHeight: 50.0,
            title: const Text("Approval Page"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            appCubit.approvalFilterChangedEvent(
                                PropertyApprovalEnum.rejected);
                          },
                          // color: AppColors.mainWhiteColor,
                          icon: const Icon(
                            Icons.cancel_sharp,
                            color: Color.fromARGB(255, 37, 72, 121),
                          ),
                          iconSize: 35,
                        ),
                        const Text("Rejected"),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            appCubit.approvalFilterChangedEvent(
                                PropertyApprovalEnum.pending);
                          },
                          // color: AppColors.mainWhiteColor,
                          icon: const Icon(
                            Icons.pending_actions_rounded,
                            color: Color.fromARGB(255, 37, 72, 121),
                          ),
                          iconSize: 35,
                        ),
                        const Text("Pending"),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            appCubit.approvalFilterChangedEvent(
                                PropertyApprovalEnum.approved);
                          },
                          // color: AppColors.mainWhiteColor,
                          icon: const Icon(
                            Icons.done,
                            color: Color.fromARGB(255, 37, 72, 121),
                          ),
                          iconSize: 35,
                        ),
                        const Text("Approval"),
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
                    // subtitle: Text( appCubit.propertyTypeList
                    //     .firstWhere(
                    //       (element) =>
                    //           element.objectId ==
                    //           appCubit.filteredProperty[index].propertyTypeId,
                    //     )
                    //     .propertyTypeName),
                    trailing: IconButton(
                      onPressed: () {
                        appCubit.approvalChangedEvent(
                            id: appCubit.filteredProperty[index].objectId,
                            newState: PropertyApprovalEnum.approved,
                            propertyModel: appCubit.filteredProperty[index]);
                      },
                      color: const Color.fromARGB(255, 27, 180, 32),
                      icon: const Icon(Icons.turn_left_outlined),
                      tooltip: "Approve",
                      iconSize: 30,
                    ),
                    leading: IconButton(
                      onPressed: () {
                        appCubit.approvalChangedEvent(
                            id: appCubit.filteredProperty[index].objectId,
                            newState: PropertyApprovalEnum.rejected,
                            propertyModel: appCubit.filteredProperty[index]);
                      },
                      icon: const Icon(Icons.cancel_schedule_send_outlined),
                      color: Colors.red,
                      tooltip: "Rejected",
                      iconSize: 28,
                    ),
                    // leading: const Icon(Icons.location_on),
                    // iconColor: const Color.fromARGB(255, 37, 72, 121),
                    // hoverColor: AppColors.mainGreyColor,
                    // tileColor: AppColors.mainWhiteColor,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
