class SuppliyingModel {
  String dOCDATE;
  String qty;
  String item;
  String toBin;
  String toLocation;
  String fromBin;
  String fromLocation;
  String pDAID;
  String statusCode;
  String dOCID;

  SuppliyingModel(
      {this.dOCDATE,
      this.qty,
      this.item,
      this.toBin,
      this.toLocation,
      this.fromBin,
      this.fromLocation,
      this.pDAID,
      this.statusCode,
      this.dOCID});

  SuppliyingModel.fromJson(Map<String, dynamic> json) {
    dOCDATE = json['DOCDATE'];
    qty = json['Qty'];
    item = json['Item'];
    toBin = json['ToBin'];
    toLocation = json['ToLocation'];
    fromBin = json['FromBin'];
    fromLocation = json['FromLocation'];
    pDAID = json['PDAID'];
    statusCode = json['StatusCode'];
    dOCID = json['DOCID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DOCDATE'] = this.dOCDATE;
    data['Qty'] = this.qty;
    data['Item'] = this.item;
    data['ToBin'] = this.toBin;
    data['ToLocation'] = this.toLocation;
    data['FromBin'] = this.fromBin;
    data['FromLocation'] = this.fromLocation;
    data['PDAID'] = this.pDAID;
    data['StatusCode'] = this.statusCode;
    data['DOCID'] = this.dOCID;
    return data;
  }
}
