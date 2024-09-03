import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomDrawerForMaleOrFemale extends StatefulWidget {
  const CustomDrawerForMaleOrFemale({super.key, required this.onChanged});

  @override
  State<CustomDrawerForMaleOrFemale> createState() => _CustomDrawerState();

  final void Function(String value) onChanged;
}

class _CustomDrawerState extends State<CustomDrawerForMaleOrFemale> {
  final List<String> items = [
    'Male',
    'Female',
  ];
  String? gender;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
            isExpanded: true,
            hint: Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text('Gender', style: Style.font18SemiBold(context)),
                ),
              ],
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: Style.font18SemiBold(context)),
                    ))
                .toList(),
            value: gender,
            onChanged: (String? value) {
              setState(() {
                gender = value;
                widget.onChanged(gender!);
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 160,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: const Color(0xffF1F4FF),
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.black,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xffF1F4FF),
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: WidgetStateProperty.all<double>(6),
                thumbVisibility: WidgetStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            )));
  }
}
