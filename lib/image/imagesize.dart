import 'package:flutter/material.dart';

class ImageSize extends StatelessWidget{    // 이미지 확대 페이지
  final int indexCheck;
  final AsyncSnapshot snapshot;
  const ImageSize({required this.snapshot, required this.indexCheck});

  @override
    Widget build(BuildContext context){
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.backspace_outlined),onPressed: (){
        Navigator.pop(context);
      },
      ),
        ),
      body:InteractiveViewer(   // 이미지 확대
          boundaryMargin: const EdgeInsets.all(1.0),  // 이미지에서 벗어날 수 있는 거리
          minScale: 1.0,  // 최소 비율
          maxScale: 10.0, // 최대 확대 비율
      child: Center(
          child:
              Image.network(snapshot.data[indexCheck]["thumbnail_url"],
                width: 400,
                height: 400,
                fit: BoxFit.fill,),
          )
      )
  );
  }
}