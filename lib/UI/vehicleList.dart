import 'package:flutter/material.dart';
import 'package:mobility_app/Models/vehiclemodel.dart';
import 'package:mobility_app/Services/webServices.dart';
import 'package:mobility_app/UI/VehicleListTile.dart';

class VechileList extends StatefulWidget {

  @override
  State<VechileList> createState() => _VechileListState();
}

class _VechileListState extends State<VechileList> {

  List<VehicleModel> vehicles = [];
  String? errorMessage;
  bool loading = true;

  Future getData() async {
    var data = await WebServices().getVehicleList();
    this.loading = false;
    if (data == null) {
      this.setState(
          () => this.errorMessage = "Please Check your Internet Connection !");
      return;
    }
    this.setState(() {
      this.errorMessage = null;
      vehicles.addAll(data);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vechile List'),
          centerTitle: true,
        ),
        body: Container(
          child: CustomScrollView(
            slivers: [
              if (this.loading)
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height: MediaQuery.of(context).size.height * (.6),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ]),
                ),
              if (this.errorMessage != null)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: MediaQuery.of(context).size.height * (.6),
                        child: Center(
                          child: Text(this.errorMessage!),
                        ),
                      )
                    ],
                  ),
                ),
                if (this.errorMessage == null && !this.loading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return VehicleListTile(
                      vehicles: vehicles[index],
                    );
                  },
                  childCount: this.vehicles.length,
                ),
              )
            ],
          ),
        ));
  }
}
