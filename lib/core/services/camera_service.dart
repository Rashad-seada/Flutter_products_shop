import 'package:image_picker/image_picker.dart';

class CameraService {

  final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImage() async  {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> takeImage() async  {
    return await picker.pickImage(source: ImageSource.camera);
  }

  Future<XFile?> pickVideo() async  {
    return await picker.pickVideo(source: ImageSource.gallery);
  }

  Future<List<XFile>> pickMultiImage() async  {
    return await picker.pickMultiImage();
  }

}