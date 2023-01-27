import 'package:flutter/material.dart';
import 'package:untitled/content/article_search_view.dart';
import 'package:untitled/favorite_view.dart';
import 'package:untitled/image/image_search_view.dart';

class Tabs extends StatefulWidget {

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {   // _TabsState 클래스는
  late PageController pageController;  // 페이지 컨트롤러
  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);  //이걸 사용한 이유를 모르겠음!
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {  // 입력된 수의 페이즈로 이동해라
    print("PAGE!!!!!");
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // column, row 와 다르게 겹쳐서 배치를 해준다. 작은걸 뒤에 입력해야 큰것에 덮히지 안는다.
        children: [
          PageView(
              physics: NeverScrollableScrollPhysics(),
              //스크롤 할 수 없도록하는 기능??? 페이지로 진행하기 때문에?
              controller: pageController,  // 시작하는 페이지 설정!! 여기서는 page 0번!!
              onPageChanged: onPageChanged,
              children: [
                // 세가지 하단바에 있는 아이콘
                ImageSearchView(),
                ArticleSearchView(),
                FavoriteView(),
              ]),
        ],
      ),
      bottomNavigationBar: BottomAppBar(  // 다른 페이지와 연결하는 하단바(탭)을 제작
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            barIcon(0),
            barIcon(1),
            barIcon(2),
          ],
        ),
      ),
    );
  }

  Widget barIcon(int page) {  // 잘 모르겠는 연산자
    return InkWell(
      child: Container(
        height: 60,
        child:
        page == 0 ? Icon(Icons.search) : page == 1 ? Icon(Icons.edit) : Icon(Icons.favorite),
      ),
      onTap: () => {
        print(page),
        navigationTapped(page),
      },
    );
  }
}
