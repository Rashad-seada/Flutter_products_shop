import 'package:eng_shop/core/error/exception.dart';
import 'package:image_picker/image_picker.dart';

class CameraService {

  final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImage() async  {
    try {
      return await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      throw ServiceException();
    }
  }

  Future<XFile?> takeImage() async  {
    try {
      return await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      throw ServiceException();
    }
  }

  Future<XFile?> pickVideo() async  {
    try {
      return await picker.pickVideo(source: ImageSource.gallery);
    } catch (e) {
      throw ServiceException();
    }
  }

  Future<List<XFile>> pickMultiImage() async  {
    try {
      return await picker.pickMultiImage();
    } catch (e) {
      throw ServiceException();
    }
  }

}