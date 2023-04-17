import 'package:flutter/material.dart';
import 'package:property_in_homs/components/custom_text_field.dart';

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          const Text('WELLCOME BACK :)'),
          const SizedBox(
            height: 10,
          ),
          const Text('You`ve been missed ;('),
          //Username textfield
          CustomTextField(
            myLabelText: 'Username',
            controller: TextEditingController(),
            fillColor: Colors.white,
          ),
          const SizedBox(height: 10),
          //Password Text field
          CustomTextField(
            myLabelText: 'Password',
            controller: TextEditingController(),
            fillColor: Colors.white,
          ),
        ]),
      ),
    );
  }
}
