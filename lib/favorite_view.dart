import 'package:flutter/material.dart';
import 'package:untitled/image/article_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _valueList = ['전체', '이미지', '내용'];
  var _selectedValue = '전체';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("관심목록"),
          centerTitle: true,
        ),
        body: Container(alignment: Alignment.topRight,
          child: DropdownButton(
            value: _selectedValue,
            items: _valueList.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
        ));
  }
}
