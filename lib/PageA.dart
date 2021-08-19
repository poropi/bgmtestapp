import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'BasePageState.dart';

class PageA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _PageA();
  }
}

class _PageA extends StatefulWidget {
  @override
  _PageAState createState() {
    return _PageAState();
  }
}

class _PageAState extends BasePageState<_PageA> {  // <-- ここの親クラスを「BasePageState」にする

  _PageAState(): super(fileName: "title_op_bgm.mp3");  // <-- 親クラスのコンストラクタにファイル名設定

  @override
  Widget buildChildWidget(BuildContext context) {  // <-- 通常のbuildメソッドの代わりに実装
    return Material(
        child: Scaffold(
            appBar: AppBar(
              title: Text("画面A"),
              automaticallyImplyLeading: true,
            ),
            body: Container(
                child: ElevatedButton(
                  child: Text("画面Bに進む"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/pageB");
                  },
                ),
              alignment: Alignment.center,
            )
        )
    );
  }
}