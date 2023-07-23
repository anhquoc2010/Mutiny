import 'package:flutter/material.dart';
import 'package:mutiny/data/models/address/recycle_bin.model.dart';
import 'package:mutiny/presentation/maps/widgets/recycle_bin_item.widget.dart';

class ListMarkerRecycleBins extends StatelessWidget {
  const ListMarkerRecycleBins({
    super.key,
    required this.recycleBins,
  });
  final List<RecycleBinModel> recycleBins;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final RecycleBinModel currentRecycleBin = recycleBins[index];

        return RecycleBinItem(currentRecycleBin: currentRecycleBin);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: recycleBins.length,
    );
  }
}
