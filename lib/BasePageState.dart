import 'package:bgmtestapp/BgmPlayer.dart';
import 'package:flutter/widgets.dart';
import '../../main.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver, RouteAware {
  BgmPlayer? _bgm;
  // 自身の画面が表に表示されているかのフラグ
  bool isActive = false;

  // コンストラクタ --------------------------------------------------
  BasePageState({String? fileName}) {
    if (fileName != null && fileName.isNotEmpty) {
      _bgm = BgmPlayer(name: "bgm/$fileName");
    }
  }

  // アプリケーションのライフサイクル start --------------------------------------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      this.onForeground();
    } else if (state == AppLifecycleState.paused) {
      this.onBackground();
    }
  }
  void onBackground() {
    // ホーム画面に切り替わり、バックグラウンド状態のとき、BGMを一時停止する
    this._bgm?.pauseBgm();
  }

  void onForeground() {
    if (this.isActive) {
      // 自分自身の画面がトップに表示されていれば、以降の処理を実施
      // ホーム画面からアプリに戻り、フォアグラウンド状態に戻ったとき、BGMを再生する
      this._bgm?.resumeBgm();
    }
  }
  // アプリケーションのライフサイクル end --------------------------------------------------
  // StatefulWidget（画面）のライフサイクル start --------------------------------------------------
  @override
  void initState() {
    super.initState();
    // アプリの状態遷移をハンドリングできるようにする
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 画面遷移をハンドリングできるようにする
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    // POP、replace時に画面終了する際、後始末をする
    this.isActive = false;
    this._bgm?.stopBgm();
    this._bgm?.disposeBgm();
    this._bgm = null;
    WidgetsBinding.instance?.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }
  // StatefulWidget（画面）のライフサイクル end --------------------------------------------------
  // 画面遷移時のライフサイクル start --------------------------------------------------
  @override
  void didPush() {
    // 自身の画面がコールされたときに、isActiveをtrueにする
    this.isActive = true;
    super.didPush();
  }

  @override
  void didPopNext() {
    // 次画面がPOPされ自身の画面に戻ってきたとき、isActiveをtrueにし、BGMを再生させる
    this.isActive = true;
    this._bgm?.resumeBgm();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    // Pushにて次画面に遷移する際、isActiveをfalseにし、BGMを一時停止させる
    this.isActive = false;
    this._bgm?.pauseBgm();
    super.didPushNext();
  }

  // 画面遷移時のライフサイクル end --------------------------------------------------

  // 子クラスにおいては標準のbuildの代わりに実装を強制させる
  // 標準のbuildを利用したい場合、本メソッドの戻り値にnullを設定可能とする
  Widget? buildChildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => WillPopScope(
        child: this.buildChildWidget(context) ?? Text(""), // 上記の抽象メソッドをコール
        onWillPop: () async {
          // 自身の画面がPOPされたときに、Playerクラスの後始末をする
          // Androidでの戻るボタンでアプリを終了させる場合、
          // POP実行前のタイミングで後始末しないとBGMが止まらなくなる・・・
          this.isActive = false;
          this._bgm?.stopBgm();
          await _bgm?.disposeBgm();
          this._bgm = null;
          return true;
        })
    );
  }
}