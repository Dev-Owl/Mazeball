import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mazeball/Views/base/baseView.dart';
import 'package:mazeball/Views/base/viewSwtichMessage.dart';
import 'package:mazeball/Views/optionBackground.dart';
import 'package:mazeball/Views/soonDialog.dart';
import 'package:mazeball/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  MazeBallGame game;
  final widthController = TextEditingController();
  final heightController = TextEditingController();

  int savedHeight = 8;
  int savedWidth = 8;

  @override
  void initState() {
    super.initState();
    game = MazeBallGame(startView: GameView.Options);
    game.blockResize = true;
    loadSettings();
  }

  Future loadSettings() async{
    var prefs = await SharedPreferences.getInstance();
    savedHeight = prefs.getInt("maze_height") ?? 8;
    savedWidth = prefs.getInt("maze_width") ?? 8;
    widthController.text = savedWidth.toString();
    heightController.text = savedHeight.toString();
  }

  void validateInput(TextEditingController controller, int savedValue) {
    var result = toInt(controller.text, defaultValue: -1);

    if ((result < 1 || result > 16) && controller.text.isNotEmpty) {
      controller.text = savedValue.toString();
      controller.selection = TextSelection(
        baseOffset: controller.text.length,
        extentOffset: controller.text.length,
      );
    } else {
      //try reloading
      rebuildMaze();
    }
  }

  void rebuildMaze() {
    var width = toInt(widthController.text);
    var height = toInt(heightController.text);
    if (height != null && width != null) {
      setState(() {
        var newSize = OptionBackgroundMessage(width, height);
        var msg = ViewSwitchMessage();
        msg.userData = newSize;
        game.sendMessageToActiveState(msg);
      });
    }
  }

  int toInt(String value, {int defaultValue, int radix = 10}) {
    try {
      return int.parse(value, radix: radix);
    } catch (error) {
      return defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          game?.widget ?? SizedBox(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.grey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Height",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Width",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 1,
                            child: _getFormatedTextField(heightController,savedHeight),
                          ),
                          Expanded(
                            flex: 4,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 1,
                            child: _getFormatedTextField(widthController,savedWidth),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Save"),
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        await prefs.setInt("maze_width", toInt(widthController.text,defaultValue: 8));
                        await prefs.setInt("maze_height", toInt(heightController.text,defaultValue: 8));
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _getFormatedTextField(TextEditingController controller,int savedValue) {
    return TextField(
      autofocus: false,
      autocorrect: false,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      decoration: new InputDecoration(
        focusColor: Colors.white,
        enabledBorder: _getDefaultBorder(),
        focusedBorder: _getDefaultBorder(),
        border: _getDefaultBorder(),
      ),
      onChanged: (s) => validateInput(controller, savedValue),
    );
  }

  InputBorder _getDefaultBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(8.0),
      ),
      borderSide: new BorderSide(
        color: Colors.white,
        width: 1.0,
      ),
    );
  }
}
