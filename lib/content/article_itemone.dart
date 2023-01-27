import 'package:flutter/material.dart';
import 'package:untitled/content/contentdetail.dart';
import 'package:untitled/image/imagedetail.dart';

class ArticleItemOne extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;

  const ArticleItemOne({required this.snapshot, required this.index});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //스냅샷을 돌리고 이런 식으로 가져온다.
      scrollDirection: Axis.vertical,

      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // 이미지 파일 클릭하면 상세페이지로 이동
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          var indexCheck = index;
                          var snapshotCheck = snapshot;
                          Navigator.push(
                            //클릭하면 ImageDetail 페이지로 이동
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContentDetail(
                                    snapshot: snapshotCheck,
                                    indexCheck: indexCheck)),
                          );
                        },
                        child: Text(
                          snapshot.data[index]["title"].replaceAll(RegExp('[^c-zA-Z4-8 가-힣\\s]'), ""),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                      width: 300,  //크기 정해줘서 글자 다 들어오게 만들기
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            strutStyle: StrutStyle(fontSize: 16.0),
                            text: TextSpan(
                                text: (snapshot.data[index]["contents"].replaceAll(RegExp('[^a-zA-Z0-9가-힣\\s]'), "")),
                                style: TextStyle(
                                    color: Colors.black,
                                    height: 1.4,
                                    fontSize: 16.0,
                                    fontFamily: 'NanumSquareRegular')),
                          )),
                        ],
                      )),
                  SizedBox.fromSize(
                    child:
                        Text(snapshot.data[index]["datetime"].substring(0, 10)),
                  ),
                ],
              ),
              Container(
                  child: IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {}
                  ))
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.2),
            thickness: 1.0,
          )
        ],
      ),
    );
  }
}
