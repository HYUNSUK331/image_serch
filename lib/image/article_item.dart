import 'package:flutter/material.dart';
import 'package:untitled/image/imagedetail.dart';

class ArticleItem extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;
  const ArticleItem({required this.snapshot, required this.index});

  @override
  State<ArticleItem> createState() => _ArtcleItemState();
}

class _ArtcleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // 스크롤 사이즈 문제 해결
        scrollDirection: Axis.vertical,
        child: Column(
          //스냅샷을 돌리고 이런 식으로 가져온다.
          children: [
            Row(children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // 이미지 파일 클릭하면 상세페이지로 이동
                    backgroundColor: Colors.white,
                    maximumSize: Size(150, 150), // 버튼 크기 키우면 이미지 알아서 맞춰준다.
                  ),
                  onPressed: () {
                    print(
                        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@$widget.index"); // 해당 인덱스 확인
                    var indexCheck = widget.index;
                    var snapshotCheck =  widget.snapshot;
                    Navigator.push(
                      //클릭하면 ImageDetail 페이지로 이동
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageDetail(
                              snapshot: snapshotCheck,
                              indexCheck:
                              indexCheck)), //여기서 snapshot,index를 그대로 받아 ImageDetail로 전달
                    );
                  },
                  child: Image.network(
                    widget.snapshot.data[ widget.index]["thumbnail_url"],
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  )),
              Text("     "), // 이건 padding 줘야할거 같다.
              Column(children: [
                Text( widget.snapshot.data[ widget.index]["datetime"].substring(0, 10)),
                Text( widget.snapshot.data[ widget.index]["display_sitename"])
              ]),
              Expanded(   // 여기는 비율로 맞췄다.
                  flex: 1,
                  child: IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {}
                  ))
            ]),
            Divider(
              color: Colors.black.withOpacity(0.2),
              thickness: 1.0,
            )
          ],
        ));
  }
}






// 메인페이지에 보여줄 이미지 리스트
/*class ArticleItem extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  const ArticleItem({required this.snapshot, required this.index});

  void check() {
    String time = snapshot.data[index]["datetime"].substring(10);
  }

  @override
  Widget build(BuildContext context) {
  }
}
*/






