import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobility_app/Models/vehiclemodel.dart';
import 'package:mobility_app/UI/vehicleDetails.dart';

class VehicleListTile extends StatefulWidget {
  final VehicleModel vehicles;

  VehicleListTile({required this.vehicles});
  @override
  _VehicleListTileState createState() =>
      _VehicleListTileState(vehicles: vehicles);
}

class _VehicleListTileState extends State<VehicleListTile> {
  final VehicleModel vehicles;

  _VehicleListTileState({required this.vehicles});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context){
            return VehicleDetails(
              id: widget.vehicles.id!,
            );
          }));
        },
          child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.vehicles.name!,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.vehicles.brand!,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              Text(
                "₹${widget.vehicles.price}",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
