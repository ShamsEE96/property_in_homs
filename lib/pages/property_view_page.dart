import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/app_cubit.dart';
import 'package:property_in_homs/utils/enums/property_state_enum.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("View Page"),
          ),
          body: SingleChildScrollView(
            child: (Column(
              children: [
                TextFormField(
                  // controller: ,
                  readOnly: true,
                  enabled: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  // controller: ,
                  readOnly: true,
                  enabled: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  // controller: ,
                  readOnly: true,
                  enabled: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    value: appCubit.propertyStateEnum.index,
                    items: [
                      DropdownMenuItem(
                        value: PropertyStateEnum.rental.index,
                        child: Text(PropertyStateEnum.rental.name),
                      ),
                      DropdownMenuItem(
                        value: PropertyStateEnum.sale.index,
                        child: Text(PropertyStateEnum.sale.name),
                      ),
                    ],
                    onChanged: (int? value) {
                      appCubit.propretyStateChangedEvent(
                          value as PropertyStateEnum);
                    },
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}
