import 'package:flutter/material.dart';
import 'package:ungohday/models/supply_detail_model.dart';
import 'package:ungohday/utility/my_style.dart';

class LotDetail extends StatefulWidget {
  final String lot;
  final List<SupplyDetailModel> models;
  LotDetail({Key key, this.lot, this.models}) : super(key: key);

  @override
  _LotDetailState createState() => _LotDetailState();
}

class _LotDetailState extends State<LotDetail> {
  String lot;
  List<SupplyDetailModel> supplyDetailModels;
  List<SupplyDetailModel> requireSupplyDetailModels = List();
  int totalQTY = 0;

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
          totalQTY = totalQTY + model.bOXQTY;
          requireSupplyDetailModels.add(model);
        });
      }
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
                            child: Text(requireSupplyDetailModels[index]
                                .bOXQTY
                                .toString()),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {},
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
