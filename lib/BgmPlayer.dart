import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers_api.dart';

class BgmPlayer {

  late AudioCache _cache = AudioCache(fixedPlayer: AudioPlayer());
  AudioPlayer? _player;

  BgmPlayer({required String name, bool isLoop = true}) {
        () async {
      await _player?.stop();
      await _player?.dispose();
      if (isLoop) {
        _player = await _cache.loop(name, mode: PlayerMode.MEDIA_PLAYER);
      } else {
        _player = await _cache.play(name, mode: PlayerMode.MEDIA_PLAYER);
      }
    }();
  }

  void resumeBgm() async {
    _player?.resume();
  }

  void pauseBgm() async {
    await _player?.pause();
  }

  void stopBgm() async {
    await _player?.stop();
  }

  Future<void> disposeBgm() async {
    return await _player?.dispose();
  }

}