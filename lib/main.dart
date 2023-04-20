import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/admin_home_page.dart';
import 'package:property_in_homs/pages/api_test_page.dart';
import 'package:property_in_homs/pages/login_page.dart';
import 'package:property_in_homs/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/cubits/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AppCubit()
        ..getProperty()
        ..getPropertyTypes()
        ..getPropertyBooking(),
    ),
    BlocProvider(
      create: (context) => AuthCubit(sp)..loadTokenFromSP(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp(
          title: "Property in Homs",
          home: RegisterPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
