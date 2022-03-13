
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:f_select_store/components/app_map.dart';
import 'package:f_select_store/components/app_text_field.dart';
import 'package:f_select_store/constants/constants.dart';
import 'package:f_select_store/constants/text_themes.dart';
import 'package:f_select_store/pages/stations/station_controller.dart';
import 'package:f_select_store/utils/formatters.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StationController sc = Get.put(StationController());
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            ConfigString.appBarTitle,
            style: ConfigTextStyles.primary(textcolor: ConfigTheme.textLight),
          ),
        ),
        actions:[
          GestureDetector(
            onTap: () => sc.onTapSearchIcon(),
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Obx((){
                switch(sc.isViewingSearch.value){
                  case true:
                  return  Icon(Icons.close);
                  default: 
                  return Icon(Icons.search);
                }
              }),
            ),
          )
        ],
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: ConfigTheme.primary,
      ),
      body: Obx((){
        switch(sc.isViewingSearch.value){
          case true:
            return  StationSearch();
          case false:
            return StationMap();
          default: 
            return Icon(Icons.search);
        }
      })
    );
  }
}

class StationMap extends StatelessWidget {
  const StationMap({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StationController sc = Get.find();
    return Container(
        color: ConfigTheme.primary,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              StationHeader(),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height-40,
                    child: Obx((){
                      switch(sc.isLoading.value){
                        case true:
                        return Center(child: CircularProgressIndicator());
                        case false:
                        return Obx(()=> GoogleMap(
                          myLocationButtonEnabled: false,
                            // onTap:(value) => sc.moveMarker(value),
                            initialCameraPosition: CameraPosition(target: sc.coordinates.value, zoom: 14),
                            onMapCreated: (GoogleMapController controller) {
                              return sc.mapController.complete(controller);
                            },
                            myLocationEnabled: true,
                            markers: { 
                              if (sc.initialPoint != null) sc.initialPoint,
                            },
                          )
                        );
                        default:
                        return SizedBox();
                      }
                    })
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.48,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: ConfigTheme.textLight,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )
                      ),
                      child: Column(
                        children: [
                          //Header
                          Obx(()=>Container(
                            padding: EdgeInsets.only(top: 15, left: 20, right: 22, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: ()=> sc.onTapBackToList(),
                                    child: Row(
                                      children: [
                                        Text(sc.isViewingDetails.value ? 'Back to list' : 'Nearby Stations', style: ConfigTextStyles.header(textsize: 17.0, textcolor: sc.isViewingDetails.value ? ConfigTheme.blue : ConfigTheme.textDark),),
                                      ],
                                    ),
                                  ), 
                                  SizedBox(width: 20,),
                                  !sc.isViewingDetails.value ? SizedBox() : Row(
                                    children: [
                                      Text('Done', style: ConfigTextStyles.header(textsize: 17.0, textcolor: ConfigTheme.blue),),
                                    ],
                                  ), 
                                ],
                              ),
                          ),),
                        Obx((){
                          switch(sc.isViewingDetails.value){
                            case true:
                            return  Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                  margin: EdgeInsets.only(left: 2),
                                  child: Text(sc.selectedStation.value.name, style: ConfigTextStyles.header(textsize: 15.0),)),
                                  Container(
                                  margin: EdgeInsets.only(left: 2),
                                  child: Text(sc.selectedStation.value.address),),
                                  Container(
                                  margin: EdgeInsets.only(left: 2),
                                  child: Text(sc.selectedStation.value.city.toUpperCase() +', ' + sc.selectedStation.value.province.toUpperCase())),
                                  SizedBox(height: 50,),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.time_to_leave, size: 18,),
                                          SizedBox(width: 2,),
                                          Text(sc.selectedStation.value.distance.toStringAsFixed(2) +'km away'),
                                        ],
                                      ), 
                                      SizedBox(width: 20,),
                                      Row(
                                        children: [
                                          Icon(Icons.timelapse, size: 18),
                                          SizedBox(width: 2,),
                                          Text(computeOpenHours(sc.selectedStation.value.opensAt, sc.selectedStation.value.closesAt)),
                                        ],
                                      ), 
                                    ],
                                  )
                                ],
                              ),
                            );
                            case false:
                            default:
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Obx((){
                                switch(sc.isStationListFetched.value){
                                  case true:
                                    return ListView.builder(
                                    itemCount: sc.stationList.value.stations.length,
                                    itemBuilder: (context, i){
                                      //CustomTile
                                      return Container(
                                        margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                        child:  ListTile(
                                          title: Obx(()=>Text(sc.stationList.value.stations[i].name, style: ConfigTextStyles.header(textsize: 15.0, textcolor: sc.isFirstLoad.value ? ConfigTheme.textDark : sc.selectedRadio.value == i  ? ConfigTheme.primary : ConfigTheme.textDark),)),
                                          subtitle: Obx(()=>Text(sc.stationList.value.stations[i].distance.toStringAsFixed(2) +'km away from you', style: ConfigTextStyles.subHeader(textcolor: sc.isFirstLoad.value ? ConfigTheme.textDark :  sc.selectedRadio.value == i ? ConfigTheme.primary : ConfigTheme.textDark),)),
                                          trailing: Obx(()=> Radio(  
                                              value: i,  
                                              groupValue: sc.isFirstLoad.value ?  -1 : sc.selectedRadio.value,  
                                              onChanged: (value) => sc.onChangeStation(value, sc.stationList.value.stations[i]),  
                                            ),)
                                        ),
                                      );
                                    }
                                  );
                                  case false:
                                  return Center(child: CircularProgressIndicator());

                                  default:
                                  return Center(child: Text('Fetching Station Data'));
                                }
                                
                              })
                            );
                          }
                        })
                        ],
                      )               
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}

class StationSearch extends StatelessWidget {
  const StationSearch({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StationController sc = Get.find();
    return Container(
      color: ConfigTheme.primary,
      child: Column(
        children: [
          StationHeader(),
          Container(
            width: MediaQuery.of(context).size.width-100,
            padding: EdgeInsets.only(bottom: 10),
            color: ConfigTheme.primary,
            child: FormTextField(
              // key: login_email,
              onChange: (value) => sc.f_select_store(value),
              hintText: ConfigString.station_search_field,
              controller: sc.search,
            ),
          ),
          Container(
          color: ConfigTheme.textLight,
          height: MediaQuery.of(context).size.height-180,
          child: Obx((){
            switch(sc.isSearching.value){
              case false:
                return ListView.builder(
                itemCount: sc.searchResult.value.stations.length,
                itemBuilder: (context, i){
                  //CustomTile
                  return Container(
                    margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child:  ListTile(
                      title: Obx(()=>Text(sc.searchResult.value.stations[i].name, style: ConfigTextStyles.header(textsize: 15.0, textcolor: sc.isFirstLoad.value ? ConfigTheme.textDark : sc.selectedRadio.value == i  ? ConfigTheme.primary : ConfigTheme.textDark),)),
                      subtitle: Obx(()=>Text(sc.searchResult.value.stations[i].distance.toStringAsFixed(2) +'km away from you', style: ConfigTextStyles.subHeader(textcolor: sc.isFirstLoad.value ? ConfigTheme.textDark :  sc.selectedRadio.value == i ? ConfigTheme.primary : ConfigTheme.textDark),)),
                      trailing: Obx(()=> Radio(  
                          value: i,  
                          groupValue: sc.isFirstLoad.value ?  -1 : sc.selectedRadio.value,  
                          onChanged: (value) => sc.onChangeStation(value, sc.searchResult.value.stations[i]),  
                        ),)
                    ),
                  );
                }
              );
              case true:
              return Center(child: CircularProgressIndicator());

              default:
              return Center(child: Text('Fetching Search List Data'));
            }
            
          })
  ),
        ],
      ),
    );
  }
}

class StationHeader extends StatelessWidget {
  const StationHeader({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConfigTheme.primary,
      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
      width: MediaQuery.of(context).size.width,
      height: 25,
      child: Text(ConfigString.station_subheader, 
      textAlign: TextAlign.center, style: ConfigTextStyles.subHeader(
        textsize: 13.0,
        textcolor: ConfigTheme.textLight,),)
    );
  }
}