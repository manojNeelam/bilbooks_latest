import 'package:flutter/material.dart';

class NewUserView1Page extends StatelessWidget {
  const NewUserView1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      height: 300,
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return SizedBox();
          }),
    ));
  }
}
