import 'package:geolocator/geolocator.dart';
import 'package:f_select_store/model/station_model.dart';
import 'package:intl/intl.dart';

  computeDistance(userLat, userLong, stationLat, stationLong){
    var distance = Geolocator.distanceBetween(userLat, userLong, stationLat, stationLong);
    return distance * 0.001;
  }

  sortList(List<Station> list){
    list.sort((a,b) => a.distance.compareTo(b.distance));
    return list;
  }

  computeOpenHours(open, close){
    String hours = "Open 24 hours";
    if(open != close){
      hours = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(open)) + " - " + DateFormat.jm().format(DateFormat("hh:mm:ss").parse(close));
    }
    return hours;
  }