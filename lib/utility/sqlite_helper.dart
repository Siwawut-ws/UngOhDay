import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ungohday/models/supply_detail_sqlite_model.dart';

class SQLLiteHelper {
  final String nameDatabase = 'mydatabase.db';
  final String supplyTable = 'suppletable';
  final int version = 1;

  final String columnId = 'id';
  final String columniTEMID = 'iTEMID';
  final String columnidOCID = 'dOCID';
  final String columnsUPPLIER = 'sUPPLIER';
  final String columnbOXID = 'bOXID';
  final String columnbOXQTY = 'bOXQTY';
  final String columnlOT = 'lOT';
  final String columnStatus = 'status';
  final String columnTypeCode = 'typeCode';

  SQLLiteHelper() {
    initDatebase();
  }

  Future<Null> initDatebase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $supplyTable ($columnId INTEGER PRIMARY KEY, $columniTEMID TEXT,$columnidOCID TEXT,$columnsUPPLIER TEXT,$columnbOXID TEXT, $columnbOXQTY INTEGER,$columnlOT TEXT,$columnStatus TEXT,$columnTypeCode TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), nameDatabase),
      );
    } catch (e) {
      return null;
    }
  }

  Future<Null> insertValueToSQLite(SupplyDetailSQLiteModel model) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        supplyTable,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('insertvalueToSQLite as ${model.iTEMID}');
    } catch (e) {
      print('e insertvalueToSQLite == ${e.toString()}');
    }
  }

  Future<List<SupplyDetailSQLiteModel>> readSQLite() async {
    Database database = await connectedDatabase();
    try {
      List<SupplyDetailSQLiteModel> models = List();
      List<Map<String, dynamic>> maps = await database.query(supplyTable);
      for (var item in maps) {
        SupplyDetailSQLiteModel model = SupplyDetailSQLiteModel.fromMap(item);
        models.add(model);
      }
      return models;
    } catch (e) {
      return null;
    }
  }

  Future<Null> deleteAllValueSQLite() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(supplyTable);
    } catch (e) {}
  }

  Future<Null> editStatusWhereId(int id) async {
    Database database = await connectedDatabase();
    try {
      await database.rawUpdate(
          'UPDATE $supplyTable SET $columnStatus = ? WHERE $columnId = ?',
          ['delete', id]);
      print('Success edit id ===> $id');
    } catch (e) {}
  }

  Future<Null> editQuelityAnStatusWhereId(int id, int boxQTY) async {
    Database database = await connectedDatabase();
    try {
      await database.rawUpdate(
          'UPDATE $supplyTable SET $columnStatus = ? , $columnbOXQTY = ? WHERE $columnId = ?',
          ['update', boxQTY, id]);
      print('Success edit id ===> $id');
    } catch (e) {}
  }
}
