import 'package:boilerlib/boilerlib.dart';
import 'package:image_picker/image_picker.dart';

//this class for invoke function pick image from gallery or camera
class PickerUtil {
  ImagePicker? _control;
  static final PickerUtil _util = PickerUtil._internal();

  factory PickerUtil() {
    return _util;
  }

  PickerUtil._internal() {
    _control = ImagePicker();
  }

  // this function for invoke open gallery to pick picture
  Future<XFile?> openGallery() async {
    try {
      await PermissionUtil().permissionStorage();
      var result = await _control?.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  // this function for invoke open camera to pick picture
  Future<XFile?> openCamera() async {
    try {
      await PermissionUtil().permissionCamera();
      var result = await _control?.pickImage(
          source: ImageSource.camera, imageQuality: 80);
      return result;
    } catch (e) {
      print(e.toString());
    }
  }
}
