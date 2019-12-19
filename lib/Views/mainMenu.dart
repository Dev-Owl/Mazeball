import 'package:flutter/material.dart';
import 'package:mazeball/Views/aboutDialog.dart';
import 'package:mazeball/Views/base/baseView.dart';
import 'package:mazeball/Views/option.dart';
import 'package:mazeball/game.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  MazeBallGame game;
  @override
  void initState() {
    super.initState();
    game = MazeBallGame(startView: GameView.MainMenuBackground);
    game.blockResize = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          game.widget,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Maze Ball",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 6,
                      color: Colors.white),
                ),
                RaisedButton(
                    child: Text("Play"),
                    onPressed: () async {
                      game.pauseGame = true; //Stop anything in our background
                      await Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => GameWidget()));
                      game.pauseGame =
                          false; //Restart it when the screen finishes
                    }),
                RaisedButton(
                    child: Text("Options"),
                    onPressed: () async {
                      game.pauseGame = true; //Stop anything in our background
                      await Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => OptionScreen()));
                      game.pauseGame = false;
                    }),
                RaisedButton(
                    child: Text("About"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return AboutMazeBallDialog();
                          });
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
