
class StationListModel {
  List<Station> stations;

  StationListModel(Map<String, dynamic> data) {
    var list = data['stations '] as List ?? [];
    List<Station> station = list.map((i) => Station.fromJson(i)).toList();
    stations = station ?? [];
  }

  Map<String, dynamic> setModelForm() {
    return{
      'stations' : stations,
    };
  }
}

class Station {
  int stationId;
  int depotId;
  String name;
  int stationCode;
  String mobileNumber;
  double latitude;
  double longitude;
  String province;              
  String city;              
  String address;              
  String stationType;              
  String opensAt;              
  String closesAt;         
  String status;              
  bool isPlbOnboarded;           
  bool isPlcOnboarded;
  double distance;          
            
  Station(Map<String, dynamic> data) {
     stationId = data['stationId'] ?? 0;
     depotId = data['depotId'] ?? 0;
     name = data['name'] ?? '';
     stationCode = data['stationCode'] ?? 0;
     mobileNumber = data['mobileNumber'] ?? '';
     latitude = data['latitude'] ?? 0;
     longitude = data['longitude'] ?? 0;
     province = data['province'] ?? '';              
     city = data['city'] ?? '';              
     address = data['address'] ?? '';              
     stationType = data['stationType'] ?? '';              
     opensAt = data['opensAt'] ?? '';              
     closesAt = data['closesAt'] ?? '';         
     status = data['status'] ?? '';              
     isPlbOnboarded = data['isPlbOnboarded'] ?? false;           
     isPlcOnboarded = data['isPlcOnboarded'] ?? false;
     distance = data['distance'] ?? 0;
  }

  Station.fromJson(Map<String, dynamic> json) {
     stationId = json['stationId'] ?? 0;
     depotId = json['depotId'] ?? 0;
     name = json['name'] ?? '';
     stationCode = json['stationCode'] ?? 0;
     mobileNumber = json['mobileNumber'] ?? '';
     latitude = json['latitude'] ?? 0;
     longitude = json['longitude'] ?? 0;
     province = json['province'] ?? '';              
     city = json['city'] ?? '';              
     address = json['address'] ?? '';              
     stationType = json['stationType'] ?? '';              
     opensAt = json['opensAt'] ?? '';              
     closesAt = json['closesAt'] ?? '';         
     status = json['status'] ?? '';              
     isPlbOnboarded = json['isPlbOnboarded'] ?? false;           
     isPlcOnboarded = json['isPlcOnboarded'] ?? false;
     distance = json['distance'] ?? 0;          
  }

  Map<String, dynamic> setModelForm() {
    return{
      "stationId" : stationId,
      "depotId" : depotId,
      "name" : name,
      "stationCode" : stationCode,
      "mobileNumber" : mobileNumber,
      "latitude" : latitude,
      "longitude" : longitude,
      "province" :  province,              
      "city" : city,             
      "address" : address,            
      "stationType" : stationType,             
      "opensAt" : opensAt,             
      "closesAt" : closesAt,        
      "status" : status,           
      "isPlbOnboarded" :  isPlbOnboarded,         
      "isPlcOnboarded" : isPlcOnboarded,
      "distance": distance
    };
  }

}

