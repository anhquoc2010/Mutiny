import 'package:flutter/material.dart';
import 'package:mutiny/common/extensions/context_extension.dart';

class RecycleBinItem extends StatelessWidget {
  const RecycleBinItem({
    super.key,
  });

  final double height = 65;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: context.width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: const Row(),
      ),
    );
  }
}
