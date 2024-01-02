import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keep_it_fresh/lib.dart';

enum SizeType {
  // ButtonWidth: 116
  small(116),

  // ButtonWidth: 128
  medium(128),

  // ButtonWidth: 186
  large(186);

  final double sizeType;

  const SizeType(this.sizeType);
}

class CommonButton extends StatelessWidget {
  final bool isEnable;
  final Color? backgroundColor;
  final Color? backgroundColorDisable;
  final Color? outLineColor;
  final String btnText;
  final TextStyle? btnTextStyle;
  final Color? btnTextColorEnable;
  final Color? btnTextColorDisable;
  final bool isOutline;
  final VoidCallback? onPress;
  final double? height;
  final double? width;
  final double? minWidth;
  final FontStyle? textFontStyle;
  final bool isLoading;
  final bool? isRadius;
  final dynamic icon;
  final double? iconSize;
  final SizeType? sizeType;

  const CommonButton({
    Key? key,
    required this.btnText,
    this.isEnable = true,
    this.backgroundColor,
    this.backgroundColorDisable,
    this.outLineColor,
    this.btnTextStyle,
    this.onPress,
    this.isOutline = false,
    this.height,
    this.width,
    this.textFontStyle,
    this.btnTextColorEnable,
    this.btnTextColorDisable,
    this.isLoading = false,
    this.isRadius = true,
    this.icon,
    this.iconSize,
    this.sizeType,
    this.minWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonText = CommonText(
      btnText,
      variant: sizeType != SizeType.medium ? Variant.medium : Variant.xxxsmall,
      textColor: isEnable
          ? btnTextColorEnable ?? Colors.white
          : btnTextColorDisable ?? AppColors.lightGray900,
      textAlign: TextAlign.center,
      fontStyle: textFontStyle ?? FontStyle.regular,
    );

    return Container(
      constraints: BoxConstraints(
        minHeight: height ?? 36.w,
        minWidth: minWidth ?? SizeType.large.sizeType.w,
      ),
      height: height ?? 36.w,
      width: minWidth,
      child: FilledButton(
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.w),
          ),
          minimumSize: const MaterialStatePropertyAll<Size>(Size.zero),
          backgroundColor: isOutline
              ? MaterialStateProperty.all(backgroundColor)
              : isEnable
                  ? MaterialStateProperty.all(
                      backgroundColor ?? const Color(0xFF9F9F9F))
                  : MaterialStateProperty.all(
                      backgroundColorDisable ?? Theme.of(context).disabledColor,
                    ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  isRadius! ? BorderRadius.circular(26.r) : BorderRadius.zero,
              side: isOutline
                  ? BorderSide(color: outLineColor ?? Colors.white)
                  : BorderSide.none,
            ),
          ),
          shadowColor:
              isOutline ? null : MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: isEnable && !isLoading ? onPress : null,
        child: isLoading
            ? CupertinoActivityIndicator(
                radius: 12,
                color:
                    isOutline ? Theme.of(context).primaryColor : Colors.white,
              )
            : icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon is Widget
                          ? icon
                          : (icon is String && icon!.contains('svg'))
                              ? SvgPicture.asset(icon!,
                                  width: iconSize,
                                  height: iconSize,
                                  colorFilter: ColorFilter.mode(
                                      !isEnable
                                          ? backgroundColor ?? AppColors.orange
                                          : AppColors.white,
                                      BlendMode.srcIn))
                              : const SizedBox(),
                      SizedBox(width: 6.w),
                      buttonText,
                    ],
                  )
                : buttonText,
      ),
    );
  }
}
