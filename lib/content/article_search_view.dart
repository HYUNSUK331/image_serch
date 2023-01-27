import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/content/article_itemone.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ArticleSearchView extends StatefulWidget {
  const ArticleSearchView({super.key});

  @override
  State<ArticleSearchView> createState() => _ArticleSearchViewState();
}

class _ArticleSearchViewState extends State<ArticleSearchView> {
  List data = [];
  final TextEditingController _textController = new TextEditingController();
  String? search;
  late int dataCount = 10;

  @override
  void initState() {  // 초기화 처음 누르면 초기화 시킨다는 개념
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("내용 검색"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (text) {
                        sendMsg(text);
                      }, //키보드로 엔터 클릭 시 호출
                      decoration: InputDecoration(
                        // labelText: '텍스트 입력',
                        hintText: '텍스트를 입력해주세요',
                        border: OutlineInputBorder(), //외곽선
                        suffixIcon: _textController.text.isNotEmpty // 버튼
                            ? Container(
                                child: IconButton(
                                  //텍스트 지우는 버튼
                                  alignment: Alignment.centerRight,
                                  icon: const Icon(
                                    Icons.cancel,
                                  ),
                                  onPressed: () {
                                    _textController.clear();
                                    setState(() {});
                                  },
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMsg(_textController.text);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.lightBlue[200],
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '검색',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$dataCount',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ), // 10개 고정 아마 API 자체에서 그렇게 나오는 듯
            FutureBuilder(
                future: getJSONData(), // Doucuments 들어와있다!!
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  dataCount = snapshot.data.length;   //이게 빨간줄 만들고 있음
                  switch (snapshot.connectionState) {
                    // 데이터 가 들어오지 못했을 때 사용
                    case ConnectionState.none:
                      return Center(
                          child: CircularProgressIndicator()); // 아무것도 없으면 실행
                    case ConnectionState.waiting:
                      return Center(
                          child:
                              CircularProgressIndicator()); // 데이터를 기다리고 있으면 실행
                    default:
                      return Expanded(
                        flex: 6,
                        child: Container(
                          // listview는 column,Row에 들어갈 수 없다.
                          height: 488,
                          child: ListView.builder(
                              // 화면에 보이는 부분만 가져와 데이터가 절약된다.
                              itemCount: snapshot.data.length, //여기서 리스트로 받음
                              itemBuilder: (BuildContext context, int index) {
                                // 인덱스는 포문 이다 여기는 포문이다.
                                return ArticleItemOne(
                                    snapshot: snapshot, index: index);
                              }),
                        ),
                      );
                  }
                })
          ],
        ),
      ),
    );
  }

  Future<List> getJSONData() async {
    var url = Uri.parse(
        'https://dapi.kakao.com/v2/search/web?query=$search'); // 이미지 안 들어오는거 고치기 이건 웹이라서 문제 발생
    var response = await http.get(url,
        headers: {"Authorization": "KakaoAK 574d2235c0f9943528e999e640414ac4"});

    var dataConvertedToJSON = json.decode(response.body);
    List result = dataConvertedToJSON["documents"];

    return result;
  }

  void sendMsg(String text) {
    _textController.clear();
    search = text;
    Fluttertoast.showToast(
      // 하단에 어떤 내용이 입력된지 알려준다.
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      // gravity: ToastGravity.CENTER,  //위치(default 는 아래)
    );
  }
}
