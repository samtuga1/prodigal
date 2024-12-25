import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final EdgeInsets padding;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;
  final String? labelText, errorText;
  final String? hintText;
  final IconData? icon;
  final double iconSize;
  final Color? enabledBorderColor;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final bool? obscureText;
  final bool enabled;
  final bool isInteractive;
  final bool isReadOnly;
  final Function()? onSuffixTap, onTap, onPrefixTap;
  final String? initialValue;
  final Widget? suffix, error, suffixIcon, prefixIcon;
  final Function(String)? onChanged;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines, maxLines;

  const CustomTextField({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
    this.validator,
    this.error,
    this.autofillHints,
    this.errorText,
    this.autovalidateMode,
    this.textInputAction,
    this.onEditingComplete,
    this.labelText,
    this.enabledBorderColor,
    this.icon,
    this.hintText,
    this.iconSize = 20,
    this.maxLines,
    this.minLines,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.onPrefixTap,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
    this.controller,
    this.inputType,
    this.obscureText,
    this.enabled = true,
    this.isInteractive = true,
    this.isReadOnly = false,
    this.onTap,
    this.suffix,
    this.onSuffixTap,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor);
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
      validator: validator,
      onChanged: onChanged,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText ?? false,
      keyboardType: inputType ?? TextInputType.text,
      initialValue: initialValue,
      enabled: enabled,
      focusNode: isReadOnly ? FocusNode() : null,
      enableInteractiveSelection: isInteractive,
      onTap: onTap,

      // style: Theme.of(context)
      //     .textTheme
      //     .titleSmall!
      //     .copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        hintText: hintText,
        error: error,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        border: const OutlineInputBorder(),
        labelStyle: hintStyle,
        hintStyle: hintStyle,
        suffix: suffix,
        suffixIconConstraints: BoxConstraints(maxHeight: 25.h, maxWidth: 35.w),
        suffixIcon: suffixIcon ??
            (icon == null
                ? null
                : IconButton(
                    highlightColor: Colors.white.withOpacity(0.3),
                    onPressed: onSuffixTap,
                    icon: Icon(
                      icon,
                      size: iconSize,
                      // color: AppColor.subtitleColor,
                    ),
                  )),
        prefixIcon: prefixIcon == null
            ? null
            : GestureDetector(
                onTap: onPrefixTap,
                child: prefixIcon,
              ),
        prefixIconConstraints: prefixIconConstraints,
        errorStyle: const TextStyle(fontSize: 12.0),
        errorMaxLines: 3,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.2,
          ),
        ),
      ),

      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
