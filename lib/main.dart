import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/bloc/states/app_states.dart';
import 'package:property_in_homs/pages/admin_home_page.dart';
import 'package:property_in_homs/pages/api_test_page.dart';
import 'package:property_in_homs/pages/property_edit_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AppCubit()
          ..getProperty()
          ..getPropertyTypes()
          ..getPropertyBooking(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp(
          title: "Api test",
          home: EditPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
