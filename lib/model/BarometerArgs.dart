import 'package:hackkimura/model/UserData.dart';

class BarometerArgs {
  var userData;
  var pressures;
  var time;
  var ddx;
  var ddy;
  var ddz;
  var mode;
  BarometerArgs({this.userData, this.pressures, this.mode});
}