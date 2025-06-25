abstract class Vehicle {
  int _speed = 0;
  void move();

  void setSpeed(int s) {
    if (s > 0) {
      _speed = s;
    } else {
      print("Speed must be positive");
    }
  }  int getSpeed() {
    return _speed;
  }
}

