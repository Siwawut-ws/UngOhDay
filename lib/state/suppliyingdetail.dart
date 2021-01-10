import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungohday/models/suppliying_model.dart';
import 'package:ungohday/models/supply_detail_model.dart';
import 'package:ungohday/state/lot_detail.dart';
import 'package:ungohday/utility/my_style.dart';

class SuppliyingDetail extends StatefulWidget {
  final SuppliyingModel model;
  SuppliyingDetail({Key key, this.model}) : super(key: key);

  @override
  _SuppliyingDetailState createState() => _SuppliyingDetailState();
}

class _SuppliyingDetailState extends State<SuppliyingDetail> {
  SuppliyingModel suppliyingModel;
  bool checkStatus;
  String status;

  List<SupplyDetailModel> supplyDetailModels = List();
  List<String> lots = List();
  Map<String, int> mapboxQtys = Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suppliyingModel = widget.model;

    if (suppliyingModel != null) {
      readData();
    }
  }

  Future<Null> readData() async {
    String path =
        'http://183.88.213.12/wsvvpack/wsvvpack.asmx/GETSUPPLYDETAIL?DOCID=${suppliyingModel.dOCID}&PDAID=${suppliyingModel.pDAID}&ITEMID=';
    print('path - $path');
    await Dio().get(path).then((value) {
      print('value======>> $value');

      int index = 0;
      var result = json.decode(value.data);
      for (var item in result) {
        if (index == 0) {
          status = item['Status'];
          print('Status =====>>>> $status');
          if (status == 'Successful...') {
            setState(() {
              checkStatus = false;
            });
          } else {
            setState(() {
              checkStatus = true;
            });
          }
        } else {
          SupplyDetailModel model = SupplyDetailModel.fromJson(item);
          supplyDetailModels.add(model);

          if (lots.length == 0) {
            setState(() {
              lots.add(model.lOT);
              mapboxQtys[model.lOT] = model.bOXQTY;
            });
          } else {
            bool addStatus = true;
            for (var item in lots) {
              if (item == model.lOT) {
                // Lot Dulucate
                addStatus = false;
                mapboxQtys[model.lOT] = mapboxQtys[model.lOT] + model.bOXQTY;
              }
            }
            if (addStatus) {
              setState(() {
                // Not Lot Dulucape
                lots.add(model.lOT);
                mapboxQtys[model.lOT] = model.bOXQTY;
              });
            }
          }
          // setState(() {
          //   supplyDetailModels.add(model);
          // });
        }
        index++;
      }
      print('mapBoxQtys --> ${mapboxQtys.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyStyle().darkBackgroud,
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text(
              'Save',
              style: MyStyle().titelH3(),
            ),
          )
        ],
        backgroundColor: MyStyle().darkBackgroud,
        title: Text('Suppliying'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildRow1(),
            buildRow('From Location', suppliyingModel.fromLocation,
                MyStyle().titelH2red()),
            buildRow(
                'From BIN', suppliyingModel.fromBin, MyStyle().titelH2red()),
            Divider(color: Colors.grey),
            buildRow('To Location', suppliyingModel.toLocation,
                MyStyle().titelH2green()),
            buildRow('To BIN', suppliyingModel.toBin, MyStyle().titelH2green()),
            Divider(color: Colors.grey),
            buildRow('ITEM', suppliyingModel.item, MyStyle().titelH2()),
            buildRow('Quantity', suppliyingModel.qty, MyStyle().titelH2()),
            buildRow('Remaining', 'text', MyStyle().titelH2()),
            showListView(),
          ],
        ),
      ),
    );
  }

  Widget showListView() {
    return checkStatus == null
        ? Expanded(child: MyStyle().showProgress())
        : checkStatus
            ? Container(
                margin: EdgeInsets.only(top: 100),
                child: Text(
                  status,
                  style: MyStyle().titelH3(),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: lots.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LotDetail(
                            lot: lots[index],models: supplyDetailModels,
                          ),
                        ));
                  },
                  child: Card(
                    color: Colors.yellow[700],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('Lot'),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(lots[index]),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('Qty'),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  mapboxQtys[lots[index]].toString(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }

  Padding buildRow(String title, String value, TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: textStyle,
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildRow1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Description :',
              style: MyStyle().titelH3(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: MyStyle().boxDecorationTextField(),
              child: TextField(),
            ),
          ),
        ],
      ),
    );
  }
}
