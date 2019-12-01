import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mazeball/game.dart';
import 'dart:async';

void main() async {
  //Make sure flame is ready before we launch our game
  await setupFlame();
  var game = new MazeBallGame();
  runApp(game.widget);
}

/// Setup all Flame specific parts
Future setupFlame() async {
  var flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp); //Force the app to be in this screen mode
}
