import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutiny/common/extensions/context_extension.dart';
import 'package:mutiny/common/theme/color_styles.dart';
import 'package:mutiny/common/theme/text_styles.dart';
import 'package:mutiny/common/widgets/common_rounded_button.dart';
import 'package:mutiny/generated/assets.gen.dart';
import 'package:mutiny/generated/locale_keys.g.dart';

class CommonError extends StatelessWidget {
  const CommonError({super.key, this.onRefresh});
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.lottie.error.lottie(
            width: context.width / 2,
          ),
          Text(
            LocaleKeys.texts_error_occur.tr(),
            style:
                TextStyles.s17RegularText.copyWith(color: ColorStyles.red500),
            textAlign: TextAlign.center,
          ),
          if (onRefresh != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CommonRoundedButton(
                onPressed: onRefresh!,
                content: LocaleKeys.button_try_again.tr(),
              ),
            )
        ],
      ),
    );
  }
}
