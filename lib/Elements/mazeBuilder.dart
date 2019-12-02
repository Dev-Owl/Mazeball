import 'dart:ui';

import 'package:theseus/theseus.dart';

class MazeBuilder {
  int _width;
  int _height;
  OrthogonalMaze _mazeGenerator;

  MazeBuilder({int width = 8, int height = 8}) {
    _width = width;
    _height = width;
  }

  void generateMaze() {
    var mazeOption = MazeOptions(width: _width, height: _height);
    _mazeGenerator = OrthogonalMaze(mazeOption);
    _mazeGenerator.generate();
  }

  void printCellDetails(int cell) {
    if (cell &  Maze.N == Maze.N) {
      print("North is open");
    } else {
      print("North is closed");
    }
    if (cell & Maze.S == Maze.S) {
      print("South is open");
    } else {
      print("South is closed");
    }
    if (cell & Maze.W == Maze.W) {
      print("West is open");
    } else {
      print("West is closed");
    }
    if (cell & Maze.E == Maze.E) {
      print("East is open");
    } else {
      print("East is closed");
    }
  }

  void render(Canvas c){
    //TODO Implement render 
  }

  void update(double t){
    //TODO Implement update 
  }

}
