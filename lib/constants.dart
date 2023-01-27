import 'package:shared_preferences/shared_preferences.dart';

class Constants{  // 상수
  static late SharedPreferences prefs;  // 기기 내부 디스크에 내용을 저장하는것
  // late는 최초 선언 시 null을 갖지만 한번 정의 된 이후로는 null을 가지지 않아도 되는 경우 사용
  // 보통 이러한 경우는 참조되기 전 다른 변수 값에 연관되어 생성자에서 값이 정의되곤 한다.

  static const FAVORITE = "favorite";
}