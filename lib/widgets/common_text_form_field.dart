import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_it_fresh/lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextFormField extends FormField<String> {
  final TextEditingController? textEditingController;

  CommonTextFormField({
    Key? key,
    bool isRequire = false,
    String? initialValue,
    String? hint,
    String? title,
    String? errorText,
    Widget? action,
    int? maxLines = 1,
    int? minLines,
    int? maxLength = 250,
    FormFieldSetter<String>? onSaved,
    bool isPassword = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization? textCapitalization,
    this.textEditingController,
    ValueChanged<String>? onChanged,
    ValueChanged<bool>? onFocusChange,
    VoidCallback? onEditingComplete,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    Color? backgroundColor,
    String? description,
    Widget? icon,
    Widget? suffix,
    Widget? prefix,
    EdgeInsets? padding,
    BoxDecoration? boxDecoration,
    FocusNode? focusNode,
    TextAlign? textAlign,
    TextStyle? style,
    TextStyle? styleTitle,
    bool readOnly = false,
    double radius = 0,
    final bool? enabled,
    AutovalidateMode? autoValidateMode,
  })  : assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        super(
          key: key,
          autovalidateMode: autoValidateMode,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (field) {
            final state = field as AppTextFormFieldState;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: styleTitle ??
                                  Theme.of(field.context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                              text: title,
                              children: [
                                if (isRequire) ...[
                                  TextSpan(
                                    style: (styleTitle ??
                                        Theme.of(field.context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                color: Colors.redAccent)),
                                    text: '※',
                                  ),
                                ]
                              ],
                            ),
                          ),
                          if (action != null) action
                        ],
                      ),
                    ),
                  Stack(
                    children: [
                      Focus(
                        onFocusChange: (value) {
                          onFocusChange;
                          if (!value) {
                            field.validate();
                          }
                        },
                        child: CupertinoTextField(
                          magnifierConfiguration:
                              TextMagnifierConfiguration.disabled,
                          textInputAction:
                              textInputAction ?? TextInputAction.done,
                          readOnly: readOnly,
                          controller: state.textEditingController,
                          padding: padding ??
                              EdgeInsets.symmetric(
                                vertical: 13.w,
                                horizontal: 15.w,
                              ),
                          obscureText: isPassword,
                          minLines: minLines,
                          maxLines: maxLines,
                          maxLength: maxLength,
                          placeholder: hint,
                          suffix: suffix,
                          prefix: prefix,
                          enabled: enabled,
                          onChanged: (value) {
                            if (onChanged != null) {
                              onChanged(value);
                            }
                            field.didChange(value);
                          },
                          onEditingComplete: () {
                            FocusScope.of(field.context)
                                .requestFocus(FocusNode());
                            if (onEditingComplete != null) {
                              onEditingComplete();
                            }
                          },
                          decoration: boxDecoration ??
                              BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                    color: field.hasError ||
                                            (errorText != null &&
                                                errorText != '')
                                        ? Colors.redAccent
                                        : AppColors.gray1,
                                    width: 1),
                                borderRadius: BorderRadius.circular(radius),
                              ),
                          style: style ??
                              Theme.of(field.context).textTheme.labelMedium,
                          keyboardType: keyboardType ?? TextInputType.text,
                          placeholderStyle: Theme.of(field.context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: Colors.black.withOpacity(0.3),
                              ),
                          inputFormatters: [
                            ...inputFormatters ?? [],
                          ],
                          textCapitalization:
                              textCapitalization ?? TextCapitalization.none,
                          focusNode: focusNode,
                          textAlign: textAlign ?? TextAlign.left,
                        ),
                      ),
                      if (icon != null) icon
                    ],
                  ),
                  if (field.hasError || (errorText != null && errorText != ''))
                    Text(
                      field.errorText ?? errorText!,
                      style: Theme.of(field.context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Colors.redAccent,
                          ),
                    ),
                ]);
          },
        );

  @override
  AppTextFormFieldState createState() {
    return AppTextFormFieldState();
  }
}

class AppTextFormFieldState extends FormFieldState<String> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController =
        (widget as CommonTextFormField).textEditingController ??
            TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
