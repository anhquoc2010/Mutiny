import 'package:flutter/material.dart';

class SheetHeader extends StatelessWidget {
  const SheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          alignment: Alignment.center,
          child: const Icon(
            Icons.horizontal_rule_rounded,
            size: 30,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
