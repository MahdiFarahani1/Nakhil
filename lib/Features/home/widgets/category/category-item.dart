import 'package:flutter/material.dart';
import 'package:nakhil/Core/const/const_color.dart';

class CatItem extends StatelessWidget {
  const CatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: ConstColor.itemBackground,
            elevation: 0),
        child: Text("تست شش"),
      ),
    );
  }
}
