import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class ImageCaptureState {
  // Using _privateImage to make sure that when photo is taken and cropping
  // is canceled, that photo is not being send to evaluate
  File _privateImage;
  File imageToSend;

  // Select an image via gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      File selected = await ImagePicker.pickImage(source: source);
      this._privateImage = selected;
    }
    catch (e){
      print("cought error: $e");
      this.imageToSend = null;
    }
  }

  Future<void> cropImage() async{
    try {
      File cropped = await ImageCropper.cropImage(
          sourcePath: this._privateImage.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.lightBlue[100],
              toolbarWidgetColor: Colors.grey[800],
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );

      this.imageToSend =  cropped;
    }
    catch (e){
      print("cought error: $e");
      this.imageToSend = null;
    }
  }

  Future<void> pickAndCropImage(ImageSource source) async {
    await pickImage(source);
    await cropImage();
  }
}