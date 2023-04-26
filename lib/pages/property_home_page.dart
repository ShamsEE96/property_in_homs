import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              // elevation: 0.0,
              backgroundColor: AppColors.seconderyBlueColor,
              // toolbarHeight: 50.0,
              title: const Text("حقل تجارب -_-"),
            ),
            backgroundColor: AppColors.seconderyBlueColor,
            body:
                appCubit.bottomNavBarPages[appCubit.navigationBarCurrentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                if (index == 1) {
                  appCubit.findAndCreateCurrentUserBookedPropertyListEvent();
                  appCubit.changeBottomNavBar(index);
                } else if (index == 2) {
                  appCubit.clearPropertyDetailsPage();
                  appCubit.changeBottomNavBar(index);
                }
                appCubit.changeBottomNavBar(index);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: appCubit.navigationBarCurrentIndex,
              elevation: 2.0,
              backgroundColor: AppColors.mainBlueColor,
              selectedItemColor: AppColors.mainNavyColor,
              unselectedItemColor: AppColors.seconderyBlueColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: "book",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "addpost",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "profile",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
