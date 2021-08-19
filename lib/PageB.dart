import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'BasePageState.dart';

class PageB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _PageB();
  }
}

class _PageB extends StatefulWidget {
  @override
  _PageBState createState() {
    return _PageBState();
  }
}

class _PageBState extends BasePageState<_PageB> {  // <-- ここの親クラスを「BasePageState」にする

  _PageBState(): super(fileName: "main_bgm.mp3");  // <-- 親クラスのコンストラクタにファイル名設定

  @override
  Widget buildChildWidget(BuildContext context) {  // <-- 通常のbuildメソッドの代わりに実装
    return Material(
        child: Scaffold(
            appBar: AppBar(
              title: Text("画面B"),
              automaticallyImplyLeading: true,
            ),
            body: Container(
              child: ElevatedButton(
                child: Text("画面Cに進む"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/pageC");
                },
              ),
              alignment: Alignment.center,
            )
        )
    );
  }
}