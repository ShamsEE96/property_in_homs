import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Control Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ApprovePropertyListPage()));
                //
              },
              child: const Text('Approve Property Ads'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add new Property Type'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('placeholder'),
            )
          ],
        ),
      ),
    );
  }
}
