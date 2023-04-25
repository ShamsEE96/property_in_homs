import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/cubits/auth_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/bloc/states/auth_states.dart';
import 'package:property_in_homs/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:property_in_homs/pages/property_home_page.dart';

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
        create: (context) => AuthCubit(sp)
          ..loadTokenFromSP()
          ..profil()
          ..loadinf())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AuthCubit authCubit = AuthCubit.get(context);
            return MaterialApp(
              title: "Property in Homs",
              home: authCubit.token != "" ? const HomeScreen() : RegisterPage(),
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
