class TipsModel {
  bool? success;
  List<TipsData>? data;

  TipsModel({this.success, this.data});

  TipsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TipsData>[];
      json['data'].forEach((v) {
        data!.add(TipsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
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
  String? cleanerName;
  String? customerName;

  TipsData({this.id, this.tipAmount, this.chargeId, this.createdAt, this.booking, this.cleaner, this.customer, this.cleanerName, this.customerName});

  TipsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipAmount = json['tip_amount'];
    chargeId = json['charge_id'];
    createdAt = json['created_at'];
    booking = json['booking'];
    cleaner = json['cleaner'];
    customer = json['customer'];
    cleanerName = json['cleaner_name'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tip_amount'] = tipAmount;
    data['charge_id'] = chargeId;
    data['created_at'] = createdAt;
    data['booking'] = booking;
    data['cleaner'] = cleaner;
    data['customer'] = customer;
    data['cleaner_name'] = cleanerName;
    data['customer_name'] = customerName;
    return data;
  }
}
