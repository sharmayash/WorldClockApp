import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String offSetHrs = data['utc_offset'].substring(1, 3);
      String offSetMinutes = data['utc_offset'].substring(4, 6);
      String dateTime = data['datetime'];

      DateTime now = DateTime.parse(dateTime);
      
      now = now.add(Duration(hours: int.parse(offSetHrs), minutes: int.parse(offSetMinutes)));
      
      isDayTime = (now.hour > 6 && now.hour < 18) ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      time = 'Could not get correct time';
    }
  }

}