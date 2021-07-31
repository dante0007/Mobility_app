import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobility_app/Models/vehicleDetailsModel.dart';
import 'package:mobility_app/Services/webServices.dart';

class VehicleDetails extends StatefulWidget {
  final int id;

  const VehicleDetails({required this.id});

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState(id: id);
}

class _VehicleDetailsState extends State<VehicleDetails> {
  VehicleDetailsModel? data;
  final int id;

  _VehicleDetailsState({required this.id});

  _getDetails() async {
    var response = await WebServices().getVehicleDetails(id);
    this.setState(() {
      data = response;
    });
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("this is id $data");
    return Scaffold(
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 2.0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: data!.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Divider(
                            thickness: 2.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5.0,
                              ),
                              Card(
                                child: CachedNetworkImage(
                                  imageUrl: data!.brand!.icon!,
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data!.name!,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    data!.brand!.name!,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 20.0),
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Retail Price"),
                            Text(
                              "₹${data!.price!.toString()}",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            const Text("Loan Available"),
                            Text(
                              "From ₹${data!.loan!.edi!} per day",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text("Condidtion Apply"),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Downpayment ₹${data!.loan!.downpayment!}",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                    elevation: 4.0,
                    child: Container(
                      color: Colors.grey[200],
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Interested in this E-Rickshaw ?",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text("Share your details"),
                          Divider(
                            thickness: 2.0,
                          ),
                          buildtextfield(label: "Enter full Name"),
                          SizedBox(height: 10.0,),
                          buildtextfield(label: "Enter 10 digit phone Number"),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width/2,
                              height: 50,
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text("Submit"),
                              ),
                              textColor: Colors.black,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  buildtextfield({String? label}) {
    return TextField(
      decoration: InputDecoration(
        hintText: label!,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
    );
  }
}
