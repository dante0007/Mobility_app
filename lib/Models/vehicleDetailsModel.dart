class VehicleDetailsModel {
  int? id;
  String? image;
  String? name;
  Brand? brand;
  int? price;
  Loan? loan;

  VehicleDetailsModel(
      {this.id, this.image, this.name, this.brand, this.price, this.loan});

  VehicleDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    price = json['price'];
    loan = json['loan'] != null ? new Loan.fromJson(json['loan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['price'] = this.price;
    if (this.loan != null) {
      data['loan'] = this.loan!.toJson();
    }
    return data;
  }
}

class Brand {
  String? name;
  String? icon;

  Brand({this.name, this.icon});

  Brand.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class Loan {
  int? downpayment;
  int? edi;

  Loan({this.downpayment, this.edi});

  Loan.fromJson(Map<String, dynamic> json) {
    downpayment = json['downpayment'];
    edi = json['edi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['downpayment'] = this.downpayment;
    data['edi'] = this.edi;
    return data;
  }
}