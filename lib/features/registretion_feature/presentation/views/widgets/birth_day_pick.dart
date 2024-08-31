import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class BirthDayPick extends StatelessWidget {
  const BirthDayPick(
      {super.key,
      required this.onChangedDay,
      required this.onChangedMonth,
      required this.onChangedYear});

  final Function(String day) onChangedDay;
  final Function(String month) onChangedMonth;
  final Function(String year) onChangedYear;
  @override
  Widget build(BuildContext context) {
    return DropdownDatePicker(
      locale: 'en_abbv',
      dateformatorder: OrderFormat.YDM, // default is myd
      inputDecoration: InputDecoration(
          fillColor: const Color(0xffF1F4FF),
          filled: true,
          errorStyle: Style.font12Bold(context).copyWith(color: Colors.red),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xff1F41BB), width: 0.7),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xff1F41BB), width: 0.7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff1F41BB)),
          )), // optional
      isDropdownHideUnderline: true, // optional
      isFormValidator: true, // optional
      startYear: 1900, // optional
      endYear: 2023, // optional
      width: 10, // optional
      onChangedDay: (value) => onChangedDay(value!),
      onChangedMonth: (value) => onChangedMonth(value!),
      onChangedYear: (value) => onChangedYear(value!),

      dayFlex: 2,
      textStyle: Style.font14Medium(context),
      hintTextStyle: Style.font14Medium(context).copyWith(fontSize: 10),

      // optional
      // optional
      hintYear: 'Year',
      hintMonth: 'Mon',
      errorDay: 'Select Day',
      errorMonth: 'Select Month',
      errorYear: 'Select Year', // optional
      // hintTextStyle: TextStyle(color: Colors.grey), // optional
    );
  }
}
