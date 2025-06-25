import 'Vehicle.dart';

class Car extends Vehicle {
  @override
  void move() {
    print("The car is moving at ${getSpeed()} km/h");
  }
}