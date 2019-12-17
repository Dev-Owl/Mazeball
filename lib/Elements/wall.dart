import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:mazeball/game.dart';
import 'package:mazeball/helper.dart';

class Wall {
  //Ref to our game object
  final MazeBallGame game;
  //Size of the ball, radius in meter
  static final double wallWidth = 5;
  //Physic objects
  Body body;
  PolygonShape shape;
  //Drawing
  Path _path;
  Paint _paint;

  Wall(this.game, Vector2 startPoint, Vector2 endPoint) {
    final scaleFactor = game.screenSize.width / game.scale;
    //Build the object as a vector2 list based on start and end
    var shapAsVectorList = _buildShapVectorList(startPoint, endPoint);
    //Box2D part
    shape = PolygonShape();
    //shape.setAsEdge(Vector2.zero(), scaleVectoreBy(endPoint,scaleFactor));
    shape.set(shapAsVectorList, shapAsVectorList.length);
    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = scaleVectoreBy(startPoint, scaleFactor);
    //Static objects are not effected by gravity but have collisions
    bd.type = BodyType.STATIC;
    body = game.world.createBody(bd);
    body.userData = this; //save a ref to the current object
    //Define body properties like weight and density
    FixtureDef fd = FixtureDef();
    fd.density = 20;
    fd.restitution = 0;
    fd.friction = 0;
    fd.shape = shape;
    body.createFixtureFromFixtureDef(fd);
    //Create a Path for drawing based on vecotor list, rquies a convert to Offset
    _path = Path();
    _path.addPolygon(
        shapAsVectorList.map((vector) => Offset(vector.x, vector.y)).toList(),
        false);
    //Painter, white walls
    _paint = Paint();
    _paint.color = Color(0xffffffff);
  }

  List<Vector2> _buildShapVectorList(Vector2 start, Vector2 end) {
    final scaleFactor = game.screenSize.width / game.scale;
    var result = new List<Vector2>();
    //Left side corner starts at (0,0) the canvas will be moved to start point
    result.add(Vector2.zero());
    //Vertical wall if start point Y is less then end point Y other wise horizontal wall
    if (start.y < end.y) {
      var endY = (start.y - end.y).abs();
      result.add(scaleVectoreBy(Vector2(0, endY), scaleFactor));
      result.add(scaleVectoreBy(Vector2(wallWidth, endY), scaleFactor));
      result.add(scaleVectoreBy(Vector2(wallWidth, 0), scaleFactor));
    } else if (start.x < end.x) {
      var endX = (start.x - end.x).abs();
      result.add(scaleVectoreBy(Vector2(endX, 0), scaleFactor));
      result.add(scaleVectoreBy(Vector2(endX, wallWidth), scaleFactor));
      result.add(scaleVectoreBy(Vector2(0, wallWidth), scaleFactor));
    }
    return result; //list of 4 points describing the edges of the wall
  }

  void render(Canvas canvas) {
    canvas.save();
    //Canvas (0,0) will be the start point of the wall -> easier to draw
    canvas.translate(body.position.x, body.position.y);
    canvas.drawPath(_path, _paint);
    canvas.restore();
  }

  //A wall has nothing todo, it just sits there ... it's a wall so no update
  
}
