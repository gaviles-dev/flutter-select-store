import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:f_select_store/model/station_model.dart';
import 'package:f_select_store/pages/stations/station_service.dart';
import 'package:f_select_store/utils/formatters.dart';
import 'package:flutter/material.dart';

class StationController extends GetxController {
  var dataSource = StationService();
  Completer<GoogleMapController> mapController = Completer();
  Rx<LatLng> user = LatLng(0,0).obs;
  Rx<LatLng> coordinates = LatLng(0,0).obs;
  Marker initialPoint; 
  Rx<StationListModel> stationList = StationListModel({}).obs;
  Rx<StationListModel> searchResult = StationListModel({}).obs;
  List<Station> tempList = [];
  Rx<Station> selectedStation = Station({}).obs;
  TextEditingController search = TextEditingController();
  var isLoading = false.obs;
  var isStationListFetched = false.obs;
  var isFirstLoad = true.obs;
  var selectedRadio = 0.obs;
  var isViewingDetails = false.obs;
  var isViewingSearch = false.obs;
  var searchCleared = true.obs;
  var isSearching = false.obs;

////////////// M A P ////////////////////////////////////////////////////////////////////////////////
  
// 1. Obtain User Current Location using geolocator
  Future<Position> getUserCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  }

// 2. Fetch location data using geolocation plugin then set to coordinates.value for the initial display
  fetchUserCurrentLocation() async {
    try{
      isLoading(true);
      var loc = await getUserCurrentLocation();
      user.value = LatLng(loc.latitude, loc.longitude);
      coordinates.value = LatLng(loc.latitude, loc.longitude);
    } finally {
      isLoading(false);
      log(coordinates.value.toString());
    }
  }

// 3. Update map marker when choosing new location
  moveMarker(LatLng pos) async {
    print(pos);
    coordinates.value = pos;
    initialPoint = Marker(
      markerId: MarkerId(""),
      infoWindow: InfoWindow(title:""),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: coordinates.value,
    );

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 192.8334901395799,
        target: coordinates.value,
        zoom: 14)
      )
    );
  }


/////////////////// N E A R B Y    L I S T /////////////////////////////////////////////////////////////////////////////////////////////
//1. Get Sorted Station List  
  fetchStationList() async {
    isStationListFetched(false);
    var fetched;
    Map<String, dynamic> responseBody;
    fetched = await dataSource.getStationList();
    if(fetched.statusCode == 200){
      try{
        responseBody = jsonDecode(fetched.body);
        for(int i=0; i<responseBody['data']['stations'].length; i++){
          //get station map
          var d = Map<String, dynamic>.from(responseBody['data']['stations'][i]);
          Station s = Station(d);
          //add distance to model
          s.distance = computeDistance(coordinates.value.latitude, coordinates.value.longitude, s.latitude, s.longitude);
          tempList.add(s);
        }
        //add sorted list to the model
        stationList.value.stations = sortList(tempList);
        searchResult = stationList;
      } finally {
        isStationListFetched(true);
      }      
    } 
  }

// 2. Update Marker based on selected station
  onChangeStation(int index, Station station){
    isFirstLoad(false);
    selectedStation.value = station;
    selectedRadio.value = index;
    moveMarker(LatLng(station.latitude, station.longitude));
    isViewingDetails(true);
  }

// Back to Nearby list
  onTapBackToList(){
    isViewingDetails(false);
    moveMarker(LatLng(user.value.latitude, user.value.longitude));
  }

/////////////////// S E A R C H  /////////////////////////////////////////////////////////////////////////////////////////////
  f_select_store(value){
    isSearching(true);
    searchResult.value.stations = searchResult.value.stations.where((station) => station.name.toLowerCase().contains(value.toLowerCase())).toList();
    isSearching(false);
  }

  onTapSearchIcon(){
    isViewingSearch.value = !isViewingSearch.value;
    if(!isViewingSearch.value){
      searchResult = stationList;
    }
  }

  @override
    void onInit() {
      fetchUserCurrentLocation();
      fetchStationList();
      super.onInit();
    }

}