import 'dart:io';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/image_picker_model.dart';
import 'package:gsform/gs_form/util/util.dart';
import 'package:gsform/gs_form/values/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class GSImagePickerField extends StatefulWidget implements GSFieldCallBack {
  final GSImagePickerModel model;
  final GSFormStyle formStyle;

  GSImagePickerField(this.model, this.formStyle, {Key? key}) : super(key: key);
  String? _croppedFilePath;

  @override
  State<GSImagePickerField> createState() => _GSImagePickerFieldState();

  @override
  getValue() {
    return _croppedFilePath;
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      return _croppedFilePath != null;
    }
  }
}

class _GSImagePickerFieldState extends State<GSImagePickerField> {
  @override
  void initState() {
    super.initState();
    if (widget.model.value != null) {
      widget._croppedFilePath = widget.model.value;
    } else {
      widget._croppedFilePath = null;
    }
  }

  @override
  void didUpdateWidget(covariant GSImagePickerField oldWidget) {
    if (widget.model.value != null) {
      widget._croppedFilePath = widget.model.value;
    } else {
      widget._croppedFilePath = oldWidget._croppedFilePath;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onTap: () {
          if (widget.model.imageSource == GSImageSource.both) {
            GSFormUtils.showImagePickerBottomSheet(
              cameraName: widget.model.cameraPopupTitle,
              galleryName: widget.model.galleryPopupTitle,
              cameraAssets: widget.model.cameraPopupIcon,
              galleryAssets: widget.model.galleryPopupIcon,
              context,
              (image) async {
                _fillImagePath(image);
              },
            );
          } else if (widget.model.imageSource == GSImageSource.camera) {
            GSFormUtils.pickImage(ImageSource.camera).then(
              (imageFile) {
                if (imageFile != null) {
                  _fillImagePath(imageFile);
                }
              },
            );
          } else {
            GSFormUtils.pickImage(ImageSource.gallery).then(
              (imageFile) {
                if (imageFile != null) {
                  _fillImagePath(imageFile);
                }
              },
            );
          }
        },
        child: widget._croppedFilePath == null
            ? NormalView(model: widget.model, formStyle: widget.formStyle)
            : ImagePickedView(
                croppedFilePath: widget._croppedFilePath!,
                model: widget.model,
                formStyle: widget.formStyle,
                onDeleteImage: () {
                  widget._croppedFilePath = null;
                  setState(() {});
                }),
      ),
    );
  }

  _fillImagePath(File image) {
    if (widget.model.showCropper ?? false) {
      _cropImage(image);
    } else {
      setState(() {});
      if (widget.model.maximumSizePerImageInBytes != null) {
        if (image.lengthSync() / 1000 < widget.model.maximumSizePerImageInBytes!) {
          widget._croppedFilePath = image.path;
        } else {
          widget.model.onErrorSizeItem?.call();
        }
      } else {
        widget._croppedFilePath = image.path;
      }
    }
  }

  Future<void> _cropImage(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio:CropAspectRatio(ratioX: 100 , ratioY: 100) ,
      compressQuality: 60,
      maxHeight: 200,
      maxWidth: 200,
      aspectRatioPresets:[
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
         // IMPORTANT: iOS supports only one custom aspect ratio in preset list
      ] ,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop photo',
            toolbarColor: GSFormColors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false ,

        ),

        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: false ,


        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        if (widget.model.maximumSizePerImageInBytes != null) {
          if (image.lengthSync() / 1000 < widget.model.maximumSizePerImageInBytes!) {
            widget._croppedFilePath = image.path;
          } else {
            widget.model.onErrorSizeItem?.call();
          }
        } else {
          widget._croppedFilePath = image.path;
        }
      });
    }
  }
}

class NormalView extends StatelessWidget {
  const NormalView({required this.model, required this.formStyle, Key? key}) : super(key: key);
  final GSImagePickerModel model;
  final GSFormStyle formStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: model.height,
      width: model.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          model.iconWidget,
          const SizedBox(height: 6.0),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ImagePickedView extends StatelessWidget {
  String croppedFilePath;
  final GSImagePickerModel model;
  final GSFormStyle formStyle;
  final VoidCallback onDeleteImage;

  ImagePickedView(
      {required this.croppedFilePath,
      Key? key,
      required this.model,
      required this.formStyle,
      required this.onDeleteImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            50,
          ),
        ),
        child: Image.file(
          File(croppedFilePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
