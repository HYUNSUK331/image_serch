import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/image/article_item.dart';

// 이미지 메인 페이지
class ImageSearchView extends StatefulWidget {
  const ImageSearchView({super.key});

  @override
  State<ImageSearchView> createState() => _ImageSearchViewState();
}

class _ImageSearchViewState extends State<ImageSearchView> {

  final TextEditingController _textController = new TextEditingController();
  String? search;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("이미지 검색"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              child: Row(// 검색 입력창 row로 정렬 해주기
                  children: [
                Expanded(
                  flex: 1, // 크기가 아닌 비율로!! 키보드 누르면 나오는 사이즈 에러 해결
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
                  ]),
            ),
            Text(''), // 검색창과 리스트 사이에 공백 만들어 주기
            FutureBuilder(
                future: getJSONData(), // Doucuments 들어와있다!!
                builder: (
                  BuildContext context,
                  AsyncSnapshot snapshot,
                ) {
                  // snapshot 상태
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
                        flex: 6, // 크기가 아닌 비율로 키보드 누르면 나오는 에러 해결
                        child: Container(
                          // listview는 column,Row에 들어갈 수 없다.
                          height: 500,
                          child: ListView.builder(
                              // 화면에 보이는 부분만 가져와 데이터가 절약된다.
                              itemCount: snapshot.data.length, //여기서 리스트로 받음
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                // 인덱스는 포문 이다 여기는 포문이다.
                                return ArticleItem(
                                    snapshot: snapshot, index: index, );
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
        'https://dapi.kakao.com/v2/search/image?query=$search'); // 이미지 안 들어오는거 고치기 이건 웹이라서 문제 발생
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
