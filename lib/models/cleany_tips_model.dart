class TipsModel {
  bool? success;
  List<TipsData>? data;

  TipsModel({this.success, this.data});

  TipsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TipsData>[];
      json['data'].forEach((v) {
        data!.add(new TipsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TipsData {
  int? id;
  String? tipAmount;
  String? chargeId;
  String? createdAt;
  String? booking;
  int? cleaner;
  int? customer;

  TipsData(
      {this.id,
        this.tipAmount,
        this.chargeId,
        this.createdAt,
        this.booking,
        this.cleaner,
        this.customer});

  TipsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipAmount = json['tip_amount'];
    chargeId = json['charge_id'];
    createdAt = json['created_at'];
    booking = json['booking'];
    cleaner = json['cleaner'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tip_amount'] = this.tipAmount;
    data['charge_id'] = this.chargeId;
    data['created_at'] = this.createdAt;
    data['booking'] = this.booking;
    data['cleaner'] = this.cleaner;
    data['customer'] = this.customer;
    return data;
  }
}
