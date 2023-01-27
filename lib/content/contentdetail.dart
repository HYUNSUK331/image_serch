import 'package:flutter/material.dart';

class ContentDetail extends StatelessWidget{
  final int indexCheck;
  final AsyncSnapshot snapshot;
  const ContentDetail({required this.snapshot, required this.indexCheck});


  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(leading: IconButton(icon: Icon(Icons.backspace_outlined),onPressed: (){
          Navigator.pop(context);
        },),
          title: Text("내용 상세"),centerTitle:true,),
        body: Center(
            child:Column(    //스냅샷을 돌리고 이런 식으로 가져온다.
              children: [
                Text(""),
                Text(snapshot.data[indexCheck]["title"],
                  style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                Container(
                  width: 300,
                child: Text(snapshot.data[indexCheck]["contents"])
                ),
                Text(""),
                Text(snapshot.data[indexCheck]["datetime"].substring(0, 10)),
              ],
            )
        )
    );
  }
}