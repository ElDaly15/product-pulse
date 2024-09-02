import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/select_item_model.dart';

class ItemBtn extends StatelessWidget {
  const ItemBtn(
      {super.key, required this.isChecked, required this.selectItemModel});
  final bool isChecked;

  final SelectItemModel selectItemModel;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(maxWidth: width * 0.38),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isChecked ? const Color(0xff1F41BB) : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            selectItemModel.iconData,
            color: isChecked ? Colors.white : Colors.black,
          ),
          SizedBox(
            width: width * 0.024,
          ),
          Text(selectItemModel.title,
              style: Style.font14SemiBold(context).copyWith(
                color: isChecked ? Colors.white : Colors.black,
              )),
        ],
      ),
    );
  }
}
