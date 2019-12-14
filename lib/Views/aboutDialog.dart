import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMazeBallDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      title: Text(
        "About Maze Ball",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Made with Flutter, Falme and Box2D by Christian Muehle. "
              "Simply move your phone to guide the ball through the maze"),
          SizedBox(
            height: 15,
          ),
          InkWell(
            child: Text(
              "GitHub",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () => launch("https://github.com/Dev-Owl/Mazeball"),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            child: Text(
              "How-to",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () => launch("https://medium.com/@c.muehle18"),
          )
        ],
      ),
    );
  }
}
