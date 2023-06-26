import 'package:flutter/material.dart';

void main() {
  runApp(App()); // 위젯을 파라미터로 필요로함.
  // App은 root 위젯이 된다.
}

// 위젯은 flutter SDK에 있는 3개의 core 위젯중 하나를 상속 받아야 함.
class App extends StatelessWidget {
  // StatelessWidget는 추상화 class로 build를 반드시 override해야함.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Scaffold는 뼈대를 만드는 class
        appBar: AppBar(
          // AppBar는 상단 헤더를 만드는 class
          title: Text('Hello flutter'),
          centerTitle: true,
        ),
        body: Center(
          // 안에 내용을 중앙으로 보내는 class
          child: Text('Hello world'),
        ),
      ),
    ); // 구글타입의 UI
    // return CupertinoApp(); // 애플타입의 UI
    // 본인이 커스터마이징을 통한 자신만의 UI를 만들고 싶어도 최초에 한번은 선택해야 함.
    // 하지만 구글에서 만들었기 때문에 아직은 MaterialApp()이 더 보기 좋음.
  }
}
