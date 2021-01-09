import 'package:flutter/material.dart';
import 'package:ungohday/utility/my_style.dart';


class SuppliyingDetail extends StatefulWidget {
  @override
  _SuppliyingDetailState createState() => _SuppliyingDetailState();
}

class _SuppliyingDetailState extends State<SuppliyingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyStyle().darkBackgroud,
        title: Text('Suppliying'),),
    );
  }
}