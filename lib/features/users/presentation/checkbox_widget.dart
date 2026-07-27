import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_box),
          SizedBox(
            height: 8,
          ),
          Expanded(child: Text("View"))
        ],
      ),
    );
  }
}
