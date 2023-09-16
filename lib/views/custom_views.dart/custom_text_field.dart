
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomInputfield extends HookWidget {
  final Function()? editingComplete;
  final String? Function(String?)? onValidate;
  final Function(String?)? onSaved;
  final bool obscure;
  final bool enabled;
  final String? fieldName;
  final bool isAutoFocus;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatter;
  final double padding;
  final double textSize;
  final double hintTextSize;
  final String? hintText;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Function()? onTap;
  final bool readOnly;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPhone;
  final Function(String)? onChanged;
  final bool hasHeaderTitle;
  final bool isAlignTop;
  final bool showObscureIcon;
  final bool isRequiredField;
  final bool fillField;
  final bool showReadOnlyPop;
  final TextAlign textAlign;
  final Function(String)? onFieldSubmitted;
  final Function? onRetryRequest;
  final bool isLoading;
  final Widget? bottomWidget;
  final FocusNode? focusNode;
  final String? helperText;
  final bool expenseField;
  final Widget? secondaryTitle;
  final TextInputAction? textInputAction;
  const CustomInputfield(
      {Key? key,
      this.bottomWidget,
      this.onFieldSubmitted,
      this.focusNode,
      this.helperText,
      this.hintTextSize = 15,
      this.textSize = 16,
      this.enabled = true,
      this.expenseField = false,
      this.isPhone = false,
      this.isAlignTop = false,
      this.isLoading = false,
      this.hasHeaderTitle = false,
      this.editingComplete,
      this.fieldName,
      this.showReadOnlyPop = false,
      this.isAutoFocus = false,
      this.onSaved,
      this.inputType,
      this.onValidate,
      this.controller,
      this.maxLines = 1,
      this.padding = 30,
      this.inputFormatter = const [],
      this.hintText,
      this.suffixWidget,
      this.prefixWidget,
      this.suffixIcon,
      this.prefixIcon,
      this.fillField = false,
      this.onTap,
      this.isRequiredField = false,
      this.showObscureIcon = false,
      this.readOnly = false,
      this.secondaryTitle,
      this.maxLength,
      this.obscure = false,
      this.onChanged,
      this.textAlign = TextAlign.start,
     
      this.onRetryRequest,
      this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFocused = useState(false);
    final isObscure = useState(true);

    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // (hasHeaderTitle && isFocused.value) ||
          //         (hasHeaderTitle && controller!.text.isNotEmpty)
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           FieldHeader(
          //               fieldName: fieldName ?? "",
          //               isRequiredField: isRequiredField),
          //           secondaryTitle ?? Container()
          //         ],
          //       )
          //     : 
              expenseField
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: TextFieldHeader(
                          textHeader: fieldName ?? "",
                          isRequiredField: isRequiredField),
                    )
                  : const SizedBox(),
          Focus(
            onFocusChange: (focus) {
              isFocused.value = focus;
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    textInputAction: textInputAction,
                    focusNode: focusNode,
                    onFieldSubmitted: onFieldSubmitted,
                    inputFormatters: inputFormatter,
                    // style:
                    //     CustomStyle.textStyleBody.copyWith(fontSize: textSize),
                    // obscuringCharacter: "*",
                    onChanged: onChanged,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText:
                        obscure || showObscureIcon ? isObscure.value : false,
                    maxLines: maxLines,
                    textAlign: textAlign,
                    readOnly: readOnly,
                    maxLength: maxLength,
                    controller: controller,
                    validator: onValidate,
                    keyboardType: inputType,
                    onSaved: onSaved,
                    onEditingComplete: editingComplete,
                    onTap:onTap,
                    decoration: InputDecoration(
                        helperText: helperText,
                        filled: true,
                        fillColor:
                            fillField ? const Color(0xffF8F9FD) : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),

                        //   isDense: true,
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 25, //25
                          minHeight: 10,
                          minWidth: 25,
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 25,
                          minHeight: 15,
                          minWidth: 15,
                        ),
                        // suffix: suffixWidget != null ? suffixWidget : null,
                        // prefix: prefixWidget != null ? prefixWidget : null,
                        suffixIcon: suffixIcon
                            ,
                       //prefixIcon: prefixIcon != null ? prefixIcon : null,
                        hintStyle: TextStyle(
                          fontSize: hintTextSize,
                          color: Color(0xffADAFB3),
                        ),
                        hintText:
                            hintText ?? (isFocused.value ? "" : fieldName),
                        enabledBorder: outlineInputBorder,
                        border: outlineInputBorder,
                        focusedBorder: outlineInputBorder),
                  ),
                ),
              ],
            ),
          ),
          bottomWidget ?? Container()
        ],
      ),
    );
  }
}

var outlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xffC4CBE2),
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(6.0),
  ),
);

var outlineBlackInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xff585B68),
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(8.0),
  ),
);

class TextFieldHeader extends StatelessWidget {
  const TextFieldHeader({
    super.key,
    required this.textHeader,
    this.isRequiredField = false,
  });
  final String textHeader;
  final bool isRequiredField;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          textHeader,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            //color: CustomColors.blackColorType3,
            fontSize: 12,
          ),
        ),
        isRequiredField
            ? const Text(
                " *",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              )
            : Container()
      ],
    );
  }
}

class CustomDropDown<T> extends HookWidget {
  final String? hint;
  final List<DropdownMenuItem<T>> items;
  final Function(dynamic) onchanged;
  final String? Function(dynamic)? validator;
  final bool hideUnderline;
  final T? selectedItem;
  final double borderRadius;
  final Widget? icon;
  final String fieldName;
  final bool hasHeaderTitle;
  final TextEditingController? controller;
  final bool isRequiredField;
  final bool isFill;
  final bool isLoading;
  final Function()? onRetry;
  const CustomDropDown({
    Key? key,
    this.hint,
    required this.items,
    required this.onchanged,
    this.hideUnderline = false,
    this.onRetry,
    this.borderRadius = 10,
    this.fieldName = "",
    this.isFill = false,
    this.isLoading = false,
    this.validator,
    this.selectedItem,
    this.controller,
    this.hasHeaderTitle = true,
    this.isRequiredField = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFocused = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (hasHeaderTitle && isFocused.value) || (hasHeaderTitle)
            ? FieldHeader(
                fieldName: fieldName, isRequiredField: isRequiredField)
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: DropdownButtonFormField<T>(
            elevation: 3,
            dropdownColor: Colors.white,
            isDense: true,
            isExpanded: true,
            icon: icon ,
            hint: Text(
             (hint ?? fieldName),
              
            ),
            value: selectedItem,
            items: isLoading || onRetry != null
                ? []
                : List<DropdownMenuItem<T>>.from(items),
           // style: CustomStyle.textStyleBody.copyWith(fontSize: 16),
            onTap: onRetry == null ? null : onRetry!(),
            onChanged: (value) {
              onchanged(value);
            },
            validator: validator,
            decoration: InputDecoration(
                filled: true,
                fillColor: isFill ? const Color(0xffF8F9FD) : Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: outlineInputBorder,
                border: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                errorBorder: outlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.red))),
          ),
        ),
      ],
    );
  }

}

class FieldHeader extends StatelessWidget {
  const FieldHeader({
    Key? key,
    required this.fieldName,
    required this.isRequiredField,
  }) : super(key: key);

  final String fieldName;
  final bool isRequiredField;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: const Color(0xffE9E9E9),
        border: Border.all(color: Colors.transparent),
      ),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fieldName,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                ),
          ),
          isRequiredField
              ? const Text(
                  " *",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.red),
                )
              : Container()
        ],
      ),
    );
  }
}