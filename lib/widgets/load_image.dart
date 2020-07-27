import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget loadImage(String linkGambar,
    {bool isShowLoading = true, Alignment alignment}) {
  if (linkGambar == null) {
    return Icon(Icons.image);
  } else {
    try {
      Widget image = CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: Uri.encodeFull(linkGambar),
        alignment: alignment ?? Alignment.center,
        placeholder: (context, url) {
          if (isShowLoading) {
            return Container(color: Colors.grey[200]);
          } else {
            return Container();
          }
        },
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.landscape,
            color: Colors.grey,
          ),
        ),
      );
      return image;
    } catch (e) {
      return Icon(Icons.error_outline);
    }
  }
}
