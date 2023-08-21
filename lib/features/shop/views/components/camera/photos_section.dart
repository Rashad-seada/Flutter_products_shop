import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class PhotosSection extends StatelessWidget {
  List<XFile> photos;

  PhotosSection({super.key,this.photos = const []});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: photos.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.h,
          crossAxisSpacing: 1.h
      ),
      itemBuilder: (context,index) {
        return Image.file(File(photos[index].path) , width: 25.w,height: 25.w,fit: BoxFit.cover,);
      }
    );
  }
}
