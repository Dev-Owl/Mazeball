import 'dart:ui';
import 'package:box2d_flame/box2d.dart' as box2d;
import 'package:mazeball/Elements/wall.dart';
import 'package:mazeball/game.dart';
import 'package:theseus/theseus.dart';

class MazeBuilder {
  int _width;
  int _height;
  OrthogonalMaze _mazeGenerator;
  final MazeBallGame game;
  Size cellSize;
  final List<Wall> walls = new List();

  MazeBuilder(this.game, {int width = 8, int height = 8}) {
    _width = width;
    _height = width;
    //Calculate the cell size to fit the screen
    cellSize = Size(
      game.screenSize.width / (width),
      game.screenSize.height / (height),
    );
  }

  void generateMaze() {
    walls.clear();
    var mazeOption = MazeOptions(width: _width, height: _height);
    _mazeGenerator = OrthogonalMaze(mazeOption);
    _mazeGenerator.generate();
    //Closing the entrance of  maze ;)
    var start = box2d.Vector2.zero();
    walls.add(Wall(
      game,
      start,
      box2d.Vector2(start.x, start.y + cellSize.height),
    ));
    //Generating a cell row by row
    for (var y = 0; y < _height; ++y) {
      var py = y * cellSize.height;
      for (var x = 0; x < _width; ++x) {
        var px = cellSize.width * x;
        generateCell(_mazeGenerator.getCell(x, y), Position.xy(x, y),
            box2d.Vector2(px, py));
      }
    }
  }

  void generateCell(int cell, Position position, box2d.Vector2 startPoint) {
    //using the bitfield to check where we have to add a wall
    if (cell & Maze.N != Maze.N) {
      walls.add(Wall(
        game,
        startPoint,
        box2d.Vector2(startPoint.x + cellSize.width, startPoint.y),
      ));
    }
    if (cell & Maze.S != Maze.S) {
      var southStart = box2d.Vector2(
          startPoint.x,
          startPoint.y +
              (cellSize.height -
                  (position.y == (_height - 1) ? Wall.wallWidth : 0)));
      walls.add(Wall(
        game,
        southStart,
        box2d.Vector2(southStart.x + cellSize.width, southStart.y),
      ));
    }

    if (cell & Maze.W != Maze.W) {
      walls.add(Wall(
        game,
        startPoint,
        box2d.Vector2(
            startPoint.x, startPoint.y + cellSize.height + Wall.wallWidth),
      ));
    }

    if (cell & Maze.E != Maze.E) {
      var eastStart = box2d.Vector2(
          startPoint.x +
              (cellSize.width -
                  (position.x == (_width - 1) ? Wall.wallWidth : 0)),
          startPoint.y);
      walls.add(Wall(
        game,
        eastStart,
        box2d.Vector2(
            eastStart.x, eastStart.y + cellSize.height + Wall.wallWidth),
      ));
    }
  }

  void render(Canvas c) {
    walls.forEach((f) => f.render(c));
  }

  void update(double t) {
    //TODO Implement update
  }
}
