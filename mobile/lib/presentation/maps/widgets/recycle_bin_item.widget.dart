import 'package:flutter/material.dart';
import 'package:mutiny/common/extensions/context_extension.dart';
import 'package:mutiny/common/theme/color_styles.dart';
import 'package:mutiny/common/theme/text_styles.dart';
import 'package:mutiny/data/models/address/recycle_bin.model.dart';
import 'package:mutiny/generated/assets.gen.dart';

class RecycleBinItem extends StatelessWidget {
  const RecycleBinItem({
    super.key,
    required this.currentRecycleBin,
  });
  final RecycleBinModel currentRecycleBin;

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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                height,
              ),
              child: currentRecycleBin.image == null
                  ? Assets.icons.launcher.appIcon.image(
                      height: height,
                      width: height,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      currentRecycleBin.image!,
                      width: height,
                      height: height,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          currentRecycleBin.name,
                          style: TextStyles.s14MediumText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 1.6,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        color: ColorStyles.gray400,
                      ),
                    ],
                  ),
                  Text(
                    currentRecycleBin.type,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
