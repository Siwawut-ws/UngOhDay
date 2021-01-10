class SupplyDetailModel {
  String iTEMID;
  String dOCID;
  String sUPPLIER;
  String bOXID;
  int bOXQTY;
  String lOT;

  SupplyDetailModel(
      {this.iTEMID,
      this.dOCID,
      this.sUPPLIER,
      this.bOXID,
      this.bOXQTY,
      this.lOT});

  SupplyDetailModel.fromJson(Map<String, dynamic> json) {
    iTEMID = json['ITEMID'];
    dOCID = json['DOCID'];
    sUPPLIER = json['SUPPLIER'];
    bOXID = json['BOXID'];
    bOXQTY = json['BOXQTY'];
    lOT = json['LOT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEMID'] = this.iTEMID;
    data['DOCID'] = this.dOCID;
    data['SUPPLIER'] = this.sUPPLIER;
    data['BOXID'] = this.bOXID;
    data['BOXQTY'] = this.bOXQTY;
    data['LOT'] = this.lOT;
    return data;
  }
}
