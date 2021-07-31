import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobility_app/Models/vehicleDetailsModel.dart';
import 'package:mobility_app/Models/vehiclemodel.dart';


class WebServices{
  final Duration mRequestTimeout = Duration(
  seconds: 10
);

Future<Map<String, String>?> getHeaders({bool? formData}) async{
    Map<String, String>? data = Map();
    if(formData==null || !formData) {
      data['Content-Type'] = 'application/json';
    }
    return data;
  }

   Future<http.Response?> getRequest({required String url}) async{
    print('GET URL: $url');
    var headers = await getHeaders();
    print('GET URL: $url');
    print('GET HEADERS: $headers');
    try{
      http.Response? response = await http.get(
          Uri.tryParse(url)!,
          headers: headers,
      ).timeout(
          mRequestTimeout,
          onTimeout: () => throw TimeoutException('Please check your internet connection!')
      );
      print('GET RESPONSE CODE ${response.statusCode}');
      print('GET RESPONSE BODY ${response.body}');
      return response;
    } on TimeoutException {
      return null;
    } on Exception {
      print('GET $url Something went wrong!');
      return null;
    }
  }

  Future<List<VehicleModel>?> getVehicleList() async{
    var response = await this.getRequest(
      url: 'https://bharatmobility.in/api/models'
    );
    if(response == null || response.statusCode != 200)return null;

    return vehicleModelFromJson(response.body);
  
  }

  Future<VehicleDetailsModel?> getVehicleDetails(int id) async{
    var response = await this.getRequest(
      url: 'https://bharatmobility.in/api/models/$id'
    );
    if(response == null || response.statusCode != 200)return null;

    return VehicleDetailsModel.fromJson(jsonDecode(response.body));
  
  }

}