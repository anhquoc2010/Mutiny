import 'package:flutter/material.dart';
import 'package:mutiny/common/theme/text_styles.dart';

class SheetHeader extends StatelessWidget {
  final String title;

  const SheetHeader({super.key, this.title = 'Title'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyles.boldText.copyWith(fontSize: 20),
          ),
        ),
        const Divider(
          height: 0,
        ),
      ],
    );
  }
}
