import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:property_in_homs/utils/colors.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: AppColors.mainWhiteColor,
        hintText: "search...",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
