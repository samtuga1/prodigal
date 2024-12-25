import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/app_loader.dart';
import 'package:prodigal/widgets/custom_cupertino_button.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Widget? child;
  final Color? textColor;
  final bool addBorder;
  final bool isBusy;
  final bool isValidated;
  final double? borderRadius, borderWidth;
  final EdgeInsets? padding;

  const AppButton({
    super.key,
    this.title,
    required this.onPressed,
    this.textStyle,
    this.borderRadius,
    this.textColor,
    this.padding,
    this.child,
    this.borderWidth,
    this.addBorder = false,
    this.isBusy = false,
    this.isValidated = true,
  }) : assert(
          title == null || child == null,
          'Cannot provide both a title and a child\n'
          'To provide both, use "child: Text(title)".',
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).buttonTheme.colorScheme!;
    final primaryColor = Theme.of(context).primaryColor;
    final borderRadius = BorderRadius.circular(this.borderRadius ?? 25);
    final buttonBorderColor = primaryColor;
    if (Platform.isIOS) {
      return Theme(
        data: Theme.of(context).copyWith(
          primaryColor: addBorder ? Colors.transparent : null,
          buttonTheme: ButtonThemeData(
            colorScheme: colorScheme.copyWith(
                onPrimary: switch ((addBorder, isValidated)) {
              (true, true) => primaryColor,
              (true, false) => theme.disabledColor,
              _ => null,
            }),
          ),
        ),
        child: CustomCupertinoButton.filled(
          borderRadius: borderRadius,
          padding: addBorder ? EdgeInsets.zero : padding ?? const EdgeInsets.symmetric(vertical: 15.5),
          minSize: addBorder ? 0 : kMinInteractiveDimensionCupertino,
          onPressed: !isValidated || isBusy
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  onPressed.call();
                },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: addBorder
                  ? Border.all(
                      width: borderWidth ?? 1,
                      color: isValidated
                          ? isBusy
                              ? theme.disabledColor
                              : buttonBorderColor
                          : theme.disabledColor,
                    )
                  : null,
            ),
            child: Padding(
              padding: addBorder ? padding ?? const EdgeInsets.symmetric(vertical: 15.5) : EdgeInsets.zero,
              child: SizedBox(
                width: double.maxFinite,
                child: isBusy
                    ? const AppLoader(
                        height: 15,
                        width: 15,
                      ).paddingSymmetric(vertical: 3)
                    : child ??
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                        ),
              ),
            ),
          ),
        ),
      );
    }
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: addBorder ? Colors.transparent : null,
        buttonTheme: ButtonThemeData(
          colorScheme: colorScheme.copyWith(
            onPrimary: (addBorder && isValidated)
                ? primaryColor
                : (addBorder && !isValidated)
                    ? theme.disabledColor
                    : null,
          ),
        ),
      ),
      child: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).buttonTheme.colorScheme!;
          return ElevatedButton(
            onPressed: isValidated && !isBusy
                ? () {
                    HapticFeedback.lightImpact();
                    onPressed.call();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              textStyle: context.textTheme.bodyMedium?.copyWith(),
              backgroundColor: Theme.of(context).primaryColor,
              disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
              foregroundColor: colorScheme.onPrimary,
              disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
              minimumSize: Size.zero,
              elevation: 0,
              padding: padding ?? const EdgeInsets.symmetric(vertical: 15.5),
              shape: addBorder
                  ? RoundedRectangleBorder(
                      borderRadius: borderRadius,
                      side: BorderSide(
                        width: borderWidth ?? 1,
                        color: isValidated
                            ? isBusy
                                ? theme.disabledColor
                                : buttonBorderColor
                            : theme.disabledColor,
                      ),
                    )
                  : RoundedRectangleBorder(
                      borderRadius: borderRadius,
                    ),
            ),
            child: !isBusy
                ? child ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title!),
                      ],
                    )
                : const AppLoader(
                    height: 15,
                    width: 15,
                  ).paddingSymmetric(vertical: 3.5),
          );
        },
      ),
    );
  }
}
