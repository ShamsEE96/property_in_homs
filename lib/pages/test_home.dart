// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
// import 'package:property_in_homs/bloc/states/app_states.dart';
// import 'package:property_in_homs/pages/admin_home_page.dart';
// import 'package:property_in_homs/pages/admin_property_approval_page.dart';
// import 'package:property_in_homs/pages/admin_property_type_edit_page.dart';
// import 'package:property_in_homs/pages/admin_property_type_home_page.dart';
// import 'package:property_in_homs/utils/colors.dart';

// class TestHomePage extends StatelessWidget {
//   const TestHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         AppCubit appCubit = AppCubit.get(context);
//         return Scaffold(
//           body: appCubit.bottomNavBarPages[appCubit.navigationBarCurrentIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             selectedFontSize: 0,
//             unselectedFontSize: 0,
//             onTap: (index) {
//               appCubit.changeBottomNavBar(index);
//             },
//             currentIndex: appCubit.navigationBarCurrentIndex,
//             selectedItemColor: AppColors.darkNavyColor,
//             unselectedItemColor: AppColors.seconderyBlueColor,
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             elevation: 0,
//             items: const [
//               BottomNavigationBarItem(
//                 label: 'Home',
//                 icon: Icon(Icons.home),
//               ),
//               BottomNavigationBarItem(
//                 label: 'Profile',
//                 icon: Icon(Icons.person),
//               ),
//               BottomNavigationBarItem(
//                 label: 'Add',
//                 icon: Icon(Icons.add),
//               ),
//               BottomNavigationBarItem(
//                 label: 'Booking`',
//                 icon: Icon(Icons.book),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
