import 'package:expense_tracker_app/views/custom_views.dart/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DateField extends HookWidget {
  final String fieldName;
  final TextEditingController controller;
  final DateTime selectedDate;
  final Function(DateTime date) onChange;
  final bool fillField;
  final bool isRequiredField;
  final DateTime? resumptionDate;
  final bool hasHeaderTitle;
  final String? Function(String?)? onValidate;
  final bool minAge;
  final bool showDateIcon;
  final double padding;

  final bool readOnly;
  const DateField(
      {Key? key,
      this.fieldName = "",
      this.onValidate,
      this.resumptionDate,
      required this.controller,
      required this.selectedDate,
      this.showDateIcon = false,
      required this.onChange,
      this.readOnly = false,
      this.minAge = false,
      this.padding = 30.0,
      this.hasHeaderTitle = true,
      this.isRequiredField = true,
      this.fillField = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickSelected = useState(selectedDate);
    return CustomInputfield(
      onValidate: onValidate,
      padding: padding,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8),
        child: Icon(
          Icons.calendar_month,
         // color: CustomColors.buttonColorType1,
        ),
      ),
      onChanged: (val) {},
      hasHeaderTitle: hasHeaderTitle,
      isRequiredField: isRequiredField,
      fillField: fillField,
      onTap: () {
         _selectDate(context, controller, datePickSelected.value, minAge);
      },
      inputType: TextInputType.datetime,
      readOnly: true,
      suffixIcon: const Icon(
        Icons.arrow_drop_down_outlined,
      ),
      controller: controller,
      fieldName: fieldName,
    );
  }

  _selectDate(BuildContext context, controller, selectedDate, isMinAge) async {
    final DateTime picked = (await showDatePicker(
            selectableDayPredicate: (DateTime val) {
              // if (resumptionDate != null) {
              //   if (val.isAfter(DateTime.now())) {
              //     return false;
              //   } else if (resumptionDate != null &&
              //       val.isBefore(resumptionDate!.subtract(Duration(days: 1)))) {
              //     return false;
              //   } else if (val == selectedDate || selectedDate == null) {
              //     return true;
              //   }
              //   return true;
              // }

              if (minAge) {
                var diff = DateTime.now().year - val.year;

                if (diff <= 14) {
                  return false;
                } else if (val == selectedDate || selectedDate == null) {
                  return true;
                }
                return true;
              }

              return true;
            },
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    // primary: CustomColors
                    //     .buttonColorType1, // header background color
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(3000))) ??
        selectedDate;

    if (picked != selectedDate) {
      onChange.call(picked);
    }
    getDate(controller, picked);
  }
}

class DateFieldExpense extends HookWidget {
  final String fieldName;
  final TextEditingController controller;
  final DateTime selectedDate;
  final Function(DateTime date) onChange;
  final bool fillField;
  final bool isRequiredField;
  final DateTime? resumptionDate;
  final bool hasHeaderTitle;
  final String? Function(String?)? onValidate;
  final bool minAge;
  final bool showDateIcon;
  final double padding;
  final bool applyForLeave;
  final bool readOnly;
  final DateFormat? format;
  const DateFieldExpense(
      {Key? key,
      this.fieldName = "",
      this.onValidate,
      this.resumptionDate,
      this.applyForLeave = false,
      required this.controller,
      required this.selectedDate,
      this.showDateIcon = false,
      required this.onChange,
      this.readOnly = false,
      this.minAge = false,
      this.padding = 30.0,
      this.hasHeaderTitle = true,
      this.format,
      this.isRequiredField = true,
      this.fillField = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickSelected = useState(selectedDate);
    return CustomInputfield(
      onValidate: onValidate,
      padding: padding,
      prefixIcon: showDateIcon
          ? null
          : const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8),
              child: Icon(
                Icons.calendar_month,
                //color: CustomColors.buttonColorType1,
              ),
            ),
      onChanged: (val) {},
      hasHeaderTitle: hasHeaderTitle,
      isRequiredField: isRequiredField,
      fillField: fillField,
      onTap: () {
        _selectDate(
                context, controller, datePickSelected.value, minAge, format);
      },
      inputType: TextInputType.datetime,
      readOnly: true,
      suffixIcon: showDateIcon
          ? null
          : const Icon(
              Icons.arrow_drop_down_outlined,
            ),
      controller: controller,
      fieldName: fieldName,
    );
  }

  _selectDate(
      BuildContext context, controller, selectedDate, isMinAge, format) async {
    final DateTime picked = (await showDatePicker(
            selectableDayPredicate: (DateTime val) {
              if (resumptionDate != null) {
                if (val.isAfter(DateTime.now())) {
                  return false;
                } else if (resumptionDate != null &&
                    val.isBefore(resumptionDate!.subtract(Duration(days: 1)))) {
                  return false;
                } else if (val == selectedDate || selectedDate == null) {
                  return true;
                }
                return true;
              }

              if (minAge) {
                var diff = DateTime.now().year - val.year;

                if (diff <= 14) {
                  return false;
                } else if (val == selectedDate || selectedDate == null) {
                  return true;
                }
                return true;
              }

              return true;
            },
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    // primary: CustomColors
                    //     .buttonColorType1, // header background color
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(3000))) ??
        selectedDate;

    if (picked != selectedDate) {
      onChange.call(picked);
    }
    getDate(controller, picked, format: format);
  }
}

getDate(TextEditingController controller, DateTime date, {DateFormat? format}) {
  controller.text = format != null
      ? format.format(date)
      : DateFormat('yyyy-MM-dd').format(date);
}