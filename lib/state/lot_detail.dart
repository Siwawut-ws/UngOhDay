import 'package:flutter/material.dart';
import 'package:ungohday/models/supply_detail_model.dart';
import 'package:ungohday/models/supply_detail_sqlite_model.dart';
import 'package:ungohday/utility/my_style.dart';
import 'package:ungohday/utility/sqlite_helper.dart';

class LotDetail extends StatefulWidget {
  final String lot;
  final List<SupplyDetailSQLiteModel> models;
  LotDetail({Key key, this.lot, this.models}) : super(key: key);

  @override
  _LotDetailState createState() => _LotDetailState();
}

class _LotDetailState extends State<LotDetail> {
  String lot;
  List<SupplyDetailSQLiteModel> supplyDetailModels;
  List<SupplyDetailSQLiteModel> requireSupplyDetailModels = List();
  int totalQTY = 0;
  String newQuelity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lot = widget.lot;
    supplyDetailModels = widget.models;
    queryModel();
  }

  void queryModel() {
    for (var model in supplyDetailModels) {
      if (model.lOT == lot) {
        setState(() {
          requireSupplyDetailModels.add(model);
        });
      }
    }
    calulateTotal();
  }

  void calulateTotal() {
    totalQTY = 0;
    if (requireSupplyDetailModels.length != 0) {
      for (var item in requireSupplyDetailModels) {
        setState(() {
          totalQTY = totalQTY + item.bOXQTY;
        });
      }
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyStyle().darkBackgroud,
      appBar: buildAppBar(context),
      body: requireSupplyDetailModels.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: requireSupplyDetailModels.length,
              itemBuilder: (context, index) => Card(
                color: Colors.yellow[700],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text('Box'),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text('Quelity'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(requireSupplyDetailModels[index].bOXID),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(requireSupplyDetailModels[index]
                                    .bOXQTY
                                    .toString()),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title: ListTile(
                                            leading: MyStyle().showLogo(),
                                            title: Text('Edit QTY'),
                                          ),
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      newQuelity = value.trim();
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    initialValue:
                                                        requireSupplyDetailModels[
                                                                index]
                                                            .bOXQTY
                                                            .toString(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    Map<String, dynamic> map =
                                                        requireSupplyDetailModels[
                                                                index]
                                                            .toMap();
                                                    map['bOXQTY'] =
                                                        int.parse(newQuelity);
                                                    setState(() {
                                                      requireSupplyDetailModels[
                                                              index] =
                                                          SupplyDetailSQLiteModel
                                                              .fromMap(map);
                                                    });
                                                    await SQLLiteHelper()
                                                        .editQuelityAnStatusWhereId(
                                                            requireSupplyDetailModels[
                                                                    index]
                                                                .id,
                                                            requireSupplyDetailModels[
                                                                    index]
                                                                .bOXQTY);
                                                    calulateTotal();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Edit'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .red.shade700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () async {
                                print(
                                    'Click Clear as id ===>> ${requireSupplyDetailModels[index].id}');
                                await SQLLiteHelper().editStatusWhereId(
                                    requireSupplyDetailModels[index].id);
                                setState(() {
                                  requireSupplyDetailModels.removeAt(index);
                                });
                                calulateTotal();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Quelity',
                style: MyStyle().titelH3(),
              ),
              Text(
                totalQTY.toString(),
                style: MyStyle().titelH3(),
              )
            ],
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 20)),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                lot,
                style: MyStyle().titelH3(),
              ),
            ),
          ],
        )
      ],
      backgroundColor: MyStyle().darkBackgroud,
      title: Text('Lot'),
    );
  }
}
