import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/enums/field_status.dart';
import 'package:gsform/gs_form/enums/filed_required_type.dart';
import 'package:gsform/gs_form/enums/filed_type.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/data_model/radio_data_model.dart';
import 'package:gsform/gs_form/model/data_model/spinner_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/bank_card_filed_model.dart';
import 'package:gsform/gs_form/model/fields_model/date_picker_model.dart';
import 'package:gsform/gs_form/model/fields_model/date_range_picker_model.dart';
import 'package:gsform/gs_form/model/fields_model/email_model.dart';
import 'package:gsform/gs_form/model/fields_model/field_model.dart';
import 'package:gsform/gs_form/model/fields_model/image_picker_model.dart';
import 'package:gsform/gs_form/model/fields_model/mobile_model.dart';
import 'package:gsform/gs_form/model/fields_model/number_model.dart';
import 'package:gsform/gs_form/model/fields_model/price_model.dart';
import 'package:gsform/gs_form/model/fields_model/qr_scanner_model.dart';
import 'package:gsform/gs_form/model/fields_model/radio_model.dart';
import 'package:gsform/gs_form/model/fields_model/spinner_model.dart';
import 'package:gsform/gs_form/model/fields_model/text_filed_model.dart';
import 'package:gsform/gs_form/model/fields_model/text_password_model.dart';
import 'package:gsform/gs_form/model/fields_model/text_plain_model.dart';
import 'package:gsform/gs_form/model/fields_model/time_picker_model.dart';
import 'package:gsform/gs_form/util/util.dart';
import 'package:gsform/gs_form/values/colors.dart';
import 'package:gsform/gs_form/values/theme.dart';
import 'package:gsform/gs_form/widget/fields/bank_card_field.dart';
import 'package:gsform/gs_form/widget/fields/date_picker_field.dart';
import 'package:gsform/gs_form/widget/fields/date_range_picker_field.dart';
import 'package:gsform/gs_form/widget/fields/email_field.dart';
import 'package:gsform/gs_form/widget/fields/image_picker_field.dart';
import 'package:gsform/gs_form/widget/fields/mobile_field.dart';
import 'package:gsform/gs_form/widget/fields/number_field.dart';
import 'package:gsform/gs_form/widget/fields/password_field.dart';
import 'package:gsform/gs_form/widget/fields/price_field.dart';
import 'package:gsform/gs_form/widget/fields/qr_scanner_field.dart';
import 'package:gsform/gs_form/widget/fields/radio_group_field.dart';
import 'package:gsform/gs_form/widget/fields/spinner_field.dart';
import 'package:gsform/gs_form/widget/fields/text_field.dart';
import 'package:gsform/gs_form/widget/fields/text_plain_field.dart';
import 'package:gsform/gs_form/widget/fields/time_picker_field.dart';

// ignore: must_be_immutable
class GSField extends StatefulWidget {
  late GSFieldModel model;
  Widget? child;
  GSFormStyle? formStyle;

  VoidCallback? onUpdate;

  update() {
    onUpdate!.call();
  }

  //<editor-fold desc="Component Constructors">

  GSField.qrScanner({
    Key? key,
    required String tag,
    String? title,
    bool? showTitle,
    String? errorMessage,
    String? helpMessage,
    bool? required,
    GSFieldStatusEnum? status,
    int? weight,
    String? hint,
    required String iconAssets,
    Color? iconColor,
  }) : super(key: key) {
    model = GSQRScannerModel(
      type: GSFieldTypeEnum.qrScanner,
      tag: tag,
      showTitle: showTitle ?? false,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      required: required,
      status: status,
      weight: weight,
      hint: hint,
      iconAsset: iconAssets,
      iconColor: iconColor,
    );
  }

  GSField.imagePicker({
    Key? key,
    required String tag,
    String? title,
    String? errorMessage,
    String? helpMessage,
    bool? required,
    bool? showTitle,
    GSFieldStatusEnum? status,
    int? weight,
    String? hint,
    String? cameraPopupTitle,
    String? galleryPopupTitle,
    String? cameraPopupIcon,
    String? galleryPopupIcon,
    required String iconAssets,
    bool? allowPickFromGallery,
    Color? iconColor,
    bool? showCropper,
  }) : super(key: key) {
    model = GSImagePickerModel(
      type: GSFieldTypeEnum.imagePicker,
      tag: tag,
      showCropper: showCropper ?? true,
      imageSource: GSImageSource.both,
      showTitle: showTitle ?? false,
      title: title,
      cameraPopupTitle: cameraPopupTitle,
      galleryPopupTitle: galleryPopupTitle,
      cameraPopupIcon: cameraPopupIcon,
      galleryPopupIcon: galleryPopupIcon,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      required: required,
      status: status,
      weight: weight,
      hint: hint,
      iconAsset: iconAssets,
      iconColor: iconColor,
    );
  }

  GSField.spinner({
    Key? key,
    required String tag,
    String? title,
    String? errorMessage,
    String? helpMessage,
    Widget? prefixWidget,
    bool? required,
    bool? showTitle,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateRegEx,
    required List<SpinnerDataModel> items,
    String? hint,
  }) : super(key: key) {
    model = GSSpinnerModel(
      type: GSFieldTypeEnum.spinner,
      tag: tag,
      showTitle: showTitle ?? true,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      required: required,
      status: status,
      value: value,
      weight: weight,
      items: items,
      hint: hint,
    );
  }

  GSField.radioGroup(
      {Key? key,
      required String tag,
      String? title,
      String? errorMessage,
      String? helpMessage,
      Widget? prefixWidget,
      bool? required,
      bool? showTitle,
      GSFieldStatusEnum? status,
      String? value,
      int? weight,
      RegExp? validateRegEx,
      String? hint,
      Axis? scrollDirection,
      Widget? selectedIcon,
      Widget? unSelectedIcon,
      bool? scrollable,
      double? height,
      required List<RadioDataModel> items,
      required ValueChanged<RadioDataModel> callBack})
      : super(key: key) {
    model = GSRadioModel(
      type: GSFieldTypeEnum.radioGroup,
      tag: tag,
      showTitle: showTitle ?? true,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      required: required,
      status: status,
      value: value,
      weight: weight,
      hint: hint,
      items: items,
      callBack: callBack,
      scrollDirection: scrollDirection,
      unSelectedIcon: unSelectedIcon,
      selectedIcon: selectedIcon,
      scrollable: scrollable ?? false,
      height: height,
    );
  }

  GSField.text(
      {Key? key,
      required String tag,
      String? title,
      String? errorMessage,
      String? helpMessage,
      Widget? prefixWidget,
      Widget? postfixWidget,
      bool? required,
      bool? showTitle,
      GSFieldStatusEnum? status,
      String? value,
      int? weight,
      RegExp? validateRegEx,
      int? maxLength,
      int? minLine,
      int? maxLine,
      String? hint})
      : super(key: key) {
    model = GSTextModel(
      type: GSFieldTypeEnum.text,
      tag: tag,
      showTitle: showTitle ?? true,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
      required: required,
      status: status,
      value: value,
      weight: weight,
      maxLength: maxLength,
      hint: hint,
    );
  }

  GSField.password(
      {Key? key,
      required String tag,
      String? title,
      String? errorMessage,
      String? helpMessage,
      Widget? prefixWidget,
      bool? required,
      bool? showTitle,
      GSFieldStatusEnum? status,
      String? value,
      int? weight,
      RegExp? validateReg,
      int? maxLength,
      int? minLine,
      int? maxLine,
      String? hint})
      : super(key: key) {
    model = GSPasswordModel(
      type: GSFieldTypeEnum.password,
      showTitle: showTitle ?? true,
      tag: tag,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      required: required,
      status: status,
      value: value,
      weight: weight,
      hint: hint,
      maxLength: maxLength,
    );
  }

  GSField.textPlain(
      {Key? key,
      required String tag,
      String? title,
      String? errorMessage,
      String? helpMessage,
      Widget? prefixWidget,
      Widget? postfixWidget,
      bool? required,
      bool? showTitle,
      GSFieldStatusEnum? status,
      String? value,
      int? weight,
      RegExp? validateRegEx,
      int? maxLength,
      int? minLine,
      int? maxLine,
      String? hint,
      bool? showCounter})
      : super(key: key) {
    model = GSTextPlainModel(
        type: GSFieldTypeEnum.textPlain,
        tag: tag,
        title: title,
        showTitle: showTitle ?? true,
        errorMessage: errorMessage,
        helpMessage: helpMessage,
        prefixWidget: prefixWidget,
        postfixWidget: postfixWidget,
        required: required,
        status: status,
        value: value,
        weight: weight,
        hint: hint,
        maxLine: maxLine,
        minLine: minLine,
        maxLength: maxLength,
        showCounter: showCounter);
  }

  GSField.mobile({
    Key? key,
    required String tag,
    String? title,
    String? errorMessage,
    String? helpMessage,
    Widget? prefixWidget,
    Widget? postfixWidget,
    bool? required,
    bool? showTitle,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateRegEx,
    int? maxLength,
    String? hint,
  }) : super(key: key) {
    model = GSMobileModel(
      type: GSFieldTypeEnum.mobile,
      tag: tag,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
      required: required,
      showTitle: showTitle ?? true,
      status: status,
      value: value,
      weight: weight,
      maxLength: maxLength,
      hint: hint,
    );
  }

  GSField.number({
    Key? key,
    required String tag,
    String? title,
    String? errorMessage,
    String? helpMessage,
    Widget? prefixWidget,
    Widget? postfixWidget,
    bool? required,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateRegEx,
    int? maxLength,
    bool? showTitle,
    String? hint,
  }) : super(key: key) {
    model = GSNumberModel(
      type: GSFieldTypeEnum.number,
      showTitle: showTitle ?? true,
      tag: tag,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
      required: required,
      status: status,
      value: value,
      weight: weight,
      maxLength: maxLength,
      hint: hint,
    );
  }

  GSField.datePicker({
    Key? key,
    required String tag,
    required GSCalendarType calendarType,
    String? title,
    String? errorMessage,
    String? helpMessage,
    Widget? prefixWidget,
    Widget? postfixWidget,
    bool? required,
    bool? showTitle,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateReg,
    int? maxLength,
    String? hint,
    GSDateFormatType? displayDateType,
    bool? isPastAvailable,
    GSDate? initialDate,
    GSDate? availableFrom,
    GSDate? availableTo,
  }) : super(key: key) {
    model = GSDatePickerModel(
        type: GSFieldTypeEnum.date,
        tag: tag,
        title: title,
        errorMessage: errorMessage,
        helpMessage: helpMessage,
        showTitle: showTitle ?? true,
        calendarType: calendarType,
        prefixWidget: prefixWidget,
        postfixWidget: postfixWidget,
        required: required,
        status: status,
        value: value,
        weight: weight,
        hint: hint,
        isPastAvailable: isPastAvailable,
        dateFormatType: displayDateType,
        initialDate: initialDate,
        availableFrom: availableTo,
        availableTo: availableTo);
  }

  GSField.dateRangePicker({
    Key? key,
    required String tag,
    required GSCalendarType calendarType,
    String? title,
    String? errorMessage,
    String? helpMessage,
    String? from,
    String? to,
    Widget? prefixWidget,
    Widget? postfixWidget,
    bool? required,
    bool? showTitle,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateReg,
    int? maxLength,
    String? hint,
    GSDateFormatType? displayDateType,
    bool? isPastAvailable,
    GSDate? initialDate,
    GSDate? availableFrom,
    GSDate? availableTo,
  }) : super(key: key) {
    model = GSDateRangePickerModel(
        type: GSFieldTypeEnum.dateRage,
        tag: tag,
        title: title,
        errorMessage: errorMessage,
        helpMessage: helpMessage,
        from: from ?? 'From ',
        to: to ?? 'To ',
        prefixWidget: prefixWidget,
        postfixWidget: postfixWidget,
        showTitle: showTitle ?? true,
        required: required,
        status: status,
        value: value,
        weight: weight,
        hint: hint,
        isPastAvailable: isPastAvailable,
        dateFormatType: displayDateType,
        initialDate: initialDate,
        availableFrom: availableTo,
        availableTo: availableTo,
        calendarType: calendarType);
  }

  GSField.time({
    Key? key,
    required String tag,
    String? title,
    String? errorMessage,
    String? helpMessage,
    Widget? prefixWidget,
    Widget? postfixWidget,
    bool? showTitle,
    bool? required,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateReg,
    int? maxLength,
    String? hint,
    TimeOfDay? initialTime,
  }) : super(key: key) {
    model = GSTimePickerModel(
        type: GSFieldTypeEnum.time,
        tag: tag,
        showTitle: showTitle ?? true,
        title: title,
        errorMessage: errorMessage,
        helpMessage: helpMessage,
        prefixWidget: prefixWidget,
        postfixWidget: postfixWidget,
        required: required,
        status: status,
        value: value,
        weight: weight,
        hint: hint,
        initialTime: initialTime);
  }

  GSField.email({
    Key? key,
    required String tag,
    String? title,
    String? errorMessage,
    String? helpMessage,
    Widget? prefixWidget,
    Widget? postfixWidget,
    bool? required,
    bool? showTitle,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateRegEx,
    int? maxLength,
    String? hint,
  }) : super(key: key) {
    model = GSEmailModel(
      type: GSFieldTypeEnum.email,
      tag: tag,
      title: title,
      showTitle: showTitle ?? true,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
      required: required,
      status: status,
      value: value,
      weight: weight,
      maxLength: maxLength,
      hint: hint,
    );
  }

  GSField.price({
    Key? key,
    required String tag,
    String? title,
    String? errorMessage,
    String? helpMessage,
    Widget? prefixWidget,
    String? currencyName,
    bool? required,
    bool? showTitle,
    GSFieldStatusEnum? status,
    String? value,
    int? weight,
    RegExp? validateRegEx,
    int? maxLength,
    String? hint,
  }) : super(key: key) {
    model = GSPriceModel(
      type: GSFieldTypeEnum.price,
      tag: tag,
      title: title,
      showTitle: showTitle ?? true,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      postfixWidget: Text(
        currencyName ?? '',
        style: GSFormTheme.textThemeStyle.headline3,
      ),
      required: required,
      status: status,
      value: value,
      weight: weight,
      maxLength: maxLength,
      hint: hint,
    );
  }

  GSField.bankCard(
      {Key? key,
      required String tag,
      String? title,
      String? errorMessage,
      String? helpMessage,
      Widget? prefixWidget,
      Widget? postfixWidget,
      bool? required,
      bool? showTitle,
      GSFieldStatusEnum? status,
      String? value,
      int? weight,
      RegExp? validateRegEx,
      int? minLine,
      int? maxLine,
      String? hint})
      : super(key: key) {
    model = GSBankCardModel(
      type: GSFieldTypeEnum.bankCard,
      tag: tag,
      title: title,
      errorMessage: errorMessage,
      helpMessage: helpMessage,
      prefixWidget: prefixWidget,
      postfixWidget: postfixWidget,
      required: required,
      status: status,
      showTitle: showTitle ?? true,
      value: value,
      weight: weight,
      hint: hint,
    );
  }

  //</editor-fold>

  @override
  State<GSField> createState() => _GSFieldState();
}

class _GSFieldState extends State<GSField> {
  @override
  void didUpdateWidget(covariant GSField oldWidget) {
    _fillChild();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _fillChild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.formStyle = widget.formStyle ?? GSFormStyle();
    widget.onUpdate = () {
      if (mounted) {
        setState(() {});
      }
    };

    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.model.showTitle!,
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Opacity(
                  opacity: _showRequiredStar(widget.model),
                  child: const Text(
                    '*',
                    style: TextStyle(color: GSFormColors.red, fontSize: 14),
                  )),
            ),
          ),
          const SizedBox(width: 1.0),
          Expanded(
            child: Column(
              children: [
                Visibility(
                  visible: widget.model.showTitle!,
                  child: Row(
                    children: [
                      Text(widget.model.title!,
                          style: widget.formStyle!.titleTextStyle),
                      const SizedBox(width: 4.0),
                      Opacity(
                        opacity: _showRequiredText(widget.model),
                        child: Text(
                          widget.formStyle!.requiredText,
                          style: const TextStyle(
                              color: GSFormColors.red, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  decoration: GSFormUtils.getFieldDecoration(
                      widget.formStyle!, widget.model.status),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible:
                            widget.model.prefixWidget == null ? false : true,
                        child: Row(
                          children: [
                            const SizedBox(width: 8.0),
                            widget.model.prefixWidget ??
                                const SizedBox(width: 0),
                            const SizedBox(width: 8.0),
                            Container(
                              height: 30.0,
                              color: GSFormColors.dividerColor,
                              width: 1.0,
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: widget.child!),
                      Visibility(
                        visible:
                            widget.model.postfixWidget == null ? false : true,
                        child: Row(
                          children: [
                            const SizedBox(width: 10.0),
                            widget.model.postfixWidget ??
                                const SizedBox(width: 0),
                            const SizedBox(width: 10.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                Opacity(
                  opacity: (widget.model.status == GSFieldStatusEnum.error &&
                              widget.model.errorMessage != null) ||
                          widget.model.helpMessage != null
                      ? 1
                      : 0,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        widget.model.status == GSFieldStatusEnum.error
                            ? 'assets/icons/ic_alret.svg'
                            : 'assets/icons/ic_info.svg',
                        width: 7.0,
                        height: 7.0,
                      ),
                      const SizedBox(width: 1.0),
                      Text(
                        widget.model.status == GSFieldStatusEnum.error
                            ? widget.model.errorMessage ?? ''
                            : widget.model.helpMessage ?? '',
                        style: widget.model.status == GSFieldStatusEnum.error
                            ? widget.formStyle!.errorTextStyle
                            : widget.formStyle!.helpTextStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showRequiredStar(GSFieldModel model) {
    if (model.required != null) {
      if (model.required!) {
        if (widget.formStyle!.requireType == GSFieldRequireTypeEnum.star) {
          return 1.0;
        }
      }
    }
    return 0.0;
  }

  _showRequiredText(GSFieldModel model) {
    if (model.required != null) {
      if (model.required!) {
        if (widget.formStyle!.requireType == GSFieldRequireTypeEnum.text) {
          return 1.0;
        }
      }
    }

    return 0.0;
  }

  _fillChild() {
    switch (widget.model.type) {
      case GSFieldTypeEnum.text:
        widget.child =
            GSTextField(widget.model as GSTextModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.number:
        widget.child =
            GSNumberField(widget.model as GSNumberModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.textPlain:
        widget.child = GSTextPlainField(
            widget.model as GSTextPlainModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.mobile:
        widget.child =
            GSMobileField(widget.model as GSMobileModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.password:
        widget.child =
            GSPasswordField(widget.model as GSPasswordModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.date:
        widget.child = GSDatePickerField(
            widget.model as GSDatePickerModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.dateRage:
        widget.child = GSDateRangePickerField(
            widget.model as GSDateRangePickerModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.time:
        widget.child = GSTimePickerField(
            widget.model as GSTimePickerModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.email:
        widget.child =
            GSEmailField(widget.model as GSEmailModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.price:
        widget.child =
            GSPriceField(widget.model as GSPriceModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.bankCard:
        widget.child =
            GSBankCardField(widget.model as GSBankCardModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.spinner:
        widget.child =
            GSSpinnerField(widget.model as GSSpinnerModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.radioGroup:
        widget.child =
            GSRadioGroupField(widget.model as GSRadioModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.imagePicker:
        widget.child = GSImagePickerField(
            widget.model as GSImagePickerModel, widget.formStyle!);
        break;
      case GSFieldTypeEnum.qrScanner:
        widget.child = GSQRScannerField(
            widget.model as GSQRScannerModel, widget.formStyle!);
        break;

      default:
        widget.child = Container();
    }
  }
}
