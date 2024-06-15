import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/text_filed_model.dart';

// ignore: must_be_immutable
class GSTextField extends StatefulWidget implements GSFieldCallBack {
  final GSTextModel model;
  final GSFormStyle formStyle;
  TextEditingController? controller;

  GSTextField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSTextField> createState() => _GSTextFieldState();

  @override
  getValue() {
    return controller!.text;
  }

  @override
  bool isValid() {
    if (model.validateRegEx == null) {
      if (!(model.required ?? false)) {
        return true;
      } else {
        return controller!.text.isNotEmpty;
      }
    } else {
      return model.validateRegEx!.hasMatch(controller!.text);
    }
  }
}

class _GSTextFieldState extends State<GSTextField> {
  @override
  void initState() {
    widget.controller ??= TextEditingController();
    if (widget.model.value != null) {
      widget.controller?.text = widget.model.value;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.model.value == widget.model.value) {
      widget.controller = oldWidget.controller;
    } else {
      widget.controller ??= TextEditingController();
      widget.controller!.text = widget.model.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.model.enableReadOnly ?? false,
      controller: widget.controller,
      maxLength: widget.model.maxLength,
      style: widget.formStyle.fieldTextStyle,
      keyboardType: TextInputType.text,
      focusNode: widget.model.focusNode,
      textInputAction: widget.model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(widget.model.nextFocusNode);
      },
      onChanged: widget.model.onChanged,

      decoration: InputDecoration(
        hintText: widget.model.hint,
        errorText: (!widget.isValid()) && (widget.controller?.text??'').length>0 ? widget.model.errorMessage:null,
        helperText: widget.model.helpMessage,
        labelText: widget.model.title,
        counterText: '',
        suffixIcon: widget.model.postfixWidget,
        prefixIcon: widget.model.prefixWidget,
        hintStyle: widget.formStyle.fieldHintStyle,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor ,width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: widget.formStyle.fieldBorderColor ,width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor ,width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor ,width: 1 ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),

      ),
    );
  }
}
