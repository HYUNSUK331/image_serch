import 'package:flutter/material.dart';
import 'package:untitled/image/imagesize.dart';
import 'package:url_launcher/url_launcher.dart';

// 이미지 상세 보기
class ImageDetail extends StatelessWidget{  // 전달 받은 snapshot,index를 리스트가 아닌 하나만 보여주기
  final int indexCheck;
  final AsyncSnapshot snapshot;
  const ImageDetail({required this.snapshot, required this.indexCheck});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.backspace_outlined),onPressed: (){
        Navigator.pop(context);
        },),
      title: Text("이미지 상세"),centerTitle:true,),
      body: Center(
          child:Column(    //스냅샷을 돌리고 이런 식으로 가져온다.
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom( // 이미지 파일 클릭하면 상세페이지로 이동
                backgroundColor: Colors.white,
                maximumSize: Size(500, 500), // 버튼 크기 키우면 이미지 알아서 맞춰준다.
              ),
                  onPressed: (){
                    var indexCheck2 = indexCheck;
                    var snapshotCheck = snapshot;
                    Navigator.push(    //클릭하면 ImageDetail 페이지로 이동
                      context,
                      MaterialPageRoute(builder: (context) => ImageSize(snapshot: snapshotCheck,indexCheck: indexCheck2)),  //여기서 snapshot,index를 그대로 받아 ImageDetail로 전달
                    );
                  },
                  child: Image.network(snapshot.data[indexCheck]["thumbnail_url"],
                    height: 300,
                    width: 300,
                    fit: BoxFit.fill,)
              ),
              Text(snapshot.data[indexCheck]["datetime"].substring(0, 10)),
              Text(snapshot.data[indexCheck]["display_sitename"]),
              Text(snapshot.data[indexCheck]["collection"]),
              Text(snapshot.data[indexCheck]["doc_url"]),
            ],
          )
        )
      );
  }
}