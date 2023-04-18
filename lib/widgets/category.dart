import 'package:flutter/material.dart';
import 'package:property_in_homs/utils/colors.dart';

class Categorys extends StatefulWidget {
  const Categorys({super.key});

  @override
  State<Categorys> createState() => _CategorysState();
}

class _CategorysState extends State<Categorys> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: AppColors.mainWhiteColor,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        Icon(
          Icons.location_city,
          color: AppColors.mainNavyColor,
        ),
        CategoryButton("sale"),
        CategoryButton("Rental"),
      ]),
    );
  }
}

Widget CategoryButton(String? text) {
  return Container(
    margin: EdgeInsets.all(5.0),
    padding: EdgeInsets.all(8.0),
    width: 100.0,
    height: 50.0,
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.mainBlueColor,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$text",
          ),
        ],
      ),
    ),
  );
}
