import 'package:flutter/material.dart';
import 'package:mutiny/common/theme/app_size.dart';
import 'package:mutiny/common/theme/text_styles.dart';
import 'package:mutiny/common/widgets/common_app_bar.dart';

class MapsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MapsAppBar({super.key, this.toolbarHeight = AppSize.appBarHeight});

  final double toolbarHeight;

  @override
  State<MapsAppBar> createState() => _MapsAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

class _MapsAppBarState extends State<MapsAppBar> {
  final List<String> recycleBinTypes = ['Recycle', 'Default'];

  String? recycleBinType;

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      toolbarHeight: widget.toolbarHeight,
      leadingWidth: 0,
      leading: const SizedBox(),
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    'Recycle bin type',
                    style: TextStyles.boldText.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  isExpanded: true,
                  value: recycleBinType,
                  onChanged: (value) {
                    setState(() {
                      recycleBinType = value;
                    });
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.red,
                      size: 16,
                    ),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  items: recycleBinTypes
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyles.boldText.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Limit',
                  hintStyle: TextStyles.boldText.copyWith(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 24,
                    maxWidth: 24,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            child: const Text('Find'),
          )
        ],
      ),
    );
  }
}
