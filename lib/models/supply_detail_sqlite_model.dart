import 'dart:convert';

class SupplyDetailSQLiteModel {
  final int id;
  final String iTEMID;
  final String dOCID;
  final String sUPPLIER;
  final String bOXID;
  final int bOXQTY;
  final String lOT;
  final String status;
  final String typeCode;
  SupplyDetailSQLiteModel({
    this.id,
    this.iTEMID,
    this.dOCID,
    this.sUPPLIER,
    this.bOXID,
    this.bOXQTY,
    this.lOT,
    this.status,
    this.typeCode,
  });
  

  SupplyDetailSQLiteModel copyWith({
    int id,
    String iTEMID,
    String dOCID,
    String sUPPLIER,
    String bOXID,
    int bOXQTY,
    String lOT,
    String status,
    String typeCode,
  }) {
    return SupplyDetailSQLiteModel(
      id: id ?? this.id,
      iTEMID: iTEMID ?? this.iTEMID,
      dOCID: dOCID ?? this.dOCID,
      sUPPLIER: sUPPLIER ?? this.sUPPLIER,
      bOXID: bOXID ?? this.bOXID,
      bOXQTY: bOXQTY ?? this.bOXQTY,
      lOT: lOT ?? this.lOT,
      status: status ?? this.status,
      typeCode: typeCode ?? this.typeCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'iTEMID': iTEMID,
      'dOCID': dOCID,
      'sUPPLIER': sUPPLIER,
      'bOXID': bOXID,
      'bOXQTY': bOXQTY,
      'lOT': lOT,
      'status': status,
      'typeCode': typeCode,
    };
  }

  factory SupplyDetailSQLiteModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SupplyDetailSQLiteModel(
      id: map['id'],
      iTEMID: map['iTEMID'],
      dOCID: map['dOCID'],
      sUPPLIER: map['sUPPLIER'],
      bOXID: map['bOXID'],
      bOXQTY: map['bOXQTY'],
      lOT: map['lOT'],
      status: map['status'],
      typeCode: map['typeCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplyDetailSQLiteModel.fromJson(String source) => SupplyDetailSQLiteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SupplyDetailSQLiteModel(id: $id, iTEMID: $iTEMID, dOCID: $dOCID, sUPPLIER: $sUPPLIER, bOXID: $bOXID, bOXQTY: $bOXQTY, lOT: $lOT, status: $status, typeCode: $typeCode)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is SupplyDetailSQLiteModel &&
      o.id == id &&
      o.iTEMID == iTEMID &&
      o.dOCID == dOCID &&
      o.sUPPLIER == sUPPLIER &&
      o.bOXID == bOXID &&
      o.bOXQTY == bOXQTY &&
      o.lOT == lOT &&
      o.status == status &&
      o.typeCode == typeCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      iTEMID.hashCode ^
      dOCID.hashCode ^
      sUPPLIER.hashCode ^
      bOXID.hashCode ^
      bOXQTY.hashCode ^
      lOT.hashCode ^
      status.hashCode ^
      typeCode.hashCode;
  }
}
