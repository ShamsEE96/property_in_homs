import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:property_in_homs/pages/property_edit_page.dart';
import 'package:property_in_homs/utils/colors.dart';
import 'package:property_in_homs/widgets/category.dart';
import 'package:property_in_homs/widgets/propertys.dart';

import 'package:property_in_homs/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.seconderyBlueColor,
        toolbarHeight: 50.0,
        title: const Text("TEST Zone"),
      ),
      backgroundColor: AppColors.seconderyBlueColor,
      body: propertys(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1.0,
        backgroundColor: AppColors.mainBlueColor,
        selectedItemColor: AppColors.darkNavyColor,
        unselectedItemColor: AppColors.seconderyBlueColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "book"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "addpost"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profil")
        ],
      ),
    );
  }
}
