import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'BasePageState.dart';

class PageC extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _PageC();
  }
}

class _PageC extends StatefulWidget {
  @override
  _PageCState createState() {
    return _PageCState();
  }
}

class _PageCState extends BasePageState<_PageC> {  // <-- ここの親クラスを「BasePageState」にする

  _PageCState(): super(fileName: "category_bgm.mp3");  // <-- 親クラスのコンストラクタにファイル名設定

  @override
  Widget buildChildWidget(BuildContext context) {  // <-- 通常のbuildメソッドの代わりに実装
    return Material(
        child: Scaffold(
            appBar: AppBar(
              title: Text("画面C"),
              automaticallyImplyLeading: true,
            ),
            body: Container(
              child: ElevatedButton(
                child: Text("画面Bに戻る"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              alignment: Alignment.center,
            )
        )
    );
  }
}