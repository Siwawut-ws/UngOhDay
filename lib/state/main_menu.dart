import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungohday/state/login.dart';
import 'package:ungohday/state/page/home_page.dart';
import 'package:ungohday/state/page/in_wh.dart';
import 'package:ungohday/state/page/out_wh.dart';
import 'package:ungohday/state/page/stock_wh.dart';
import 'package:ungohday/state/storing.dart';
import 'package:ungohday/state/supplying.dart';
import 'package:ungohday/utility/my_constant.dart';
import 'package:ungohday/utility/my_style.dart';

class MainMenu extends StatefulWidget {
  final String name, type, storing;
  MainMenu({Key key, this.name, this.type, this.storing}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String name, type, storing;
  Widget currentWidget = HomePage();
  List<String> types = List();
  List<String> titleMenus = MyConstant().titleMenus;
  List<IconData> iconMenus = MyConstant().iconMenus;
  List<Widget> currentWidgets = MyConstant().currentWidgets;
  List<List<String>> subTitles = MyConstant().subTitles;
  List<String> showMenus = List();
  List<IconData> showIcons = List();
  List<Widget> showWidgets = List();
  List<List<String>> showSubTitles = List();

  List<String> titleAppBars = [
    'หน้าแรก',
    'การรับเข้า WH',
    'การส่งออก WH',
    'สต๊อคใน WH',
    'Suppliying'
  ];
  String titleAppBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
    type = widget.type;
    storing = widget.storing;
    titleAppBar = titleAppBars[0];
    // print('name = $name, type = $type, storing = $storing');
    // createArea();
  }

  void createArea() {
    String string = type.substring(1, type.length - 1);
    print('string = $string');
    types = string.split(',');
    int index = 0;
    for (var item in types) {
      types[index] = item.trim();
      if (types[index] == '10') {
        setState(() {
          showMenus.add(titleMenus[index]);
          showIcons.add(iconMenus[index]);
          showWidgets.add(currentWidgets[index]);
          showSubTitles.add(subTitles[index]);
        });
      }
      index++;
    }
    currentWidget = showWidgets[0];
    print('types = $types');
    print('showMenus = $showMenus');
    print('showSubTitles = ${showSubTitles.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
        backgroundColor: MyStyle().darkBackgroud,
      ),
      drawer: buildDrawer2(),
      body: currentWidget == null ? MyStyle().showProgress() : currentWidget,
    );
  }

  Drawer buildDrawer2() => Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildListTileHome(),
                buildListTileSuppliying(),
                // buildListTileInWH(),
                // buildListTileOutWH(),
                // buildListTileStockWH(),
              ],
            ),
            buildListTileSingOut()
          ],
        ),
      );

  ListTile buildListTileSuppliying() {
    return ListTile(
      leading: Icon(Icons.support_agent_outlined),
      title: Text('Suppliying'),
      onTap: () {
        setState(() {
          currentWidget = Suppliying();
          titleAppBar = titleAppBars[4];
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileHome() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('หน้าแรก'),
      onTap: () {
        setState(() {
          currentWidget = HomePage();
          titleAppBar = titleAppBars[0];
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileInWH() {
    return ListTile(
      leading: Icon(Icons.insert_invitation),
      title: Text('การรับเข้า WH'),
      onTap: () {
        setState(() {
          currentWidget = InWH();
          titleAppBar = titleAppBars[1];
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileOutWH() {
    return ListTile(
      leading: Icon(Icons.outbox),
      title: Text('การส่งออก WH'),
      onTap: () {
        setState(() {
          currentWidget = OutWH();
          titleAppBar = titleAppBars[2];
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileStockWH() {
    return ListTile(
      leading: Icon(Icons.memory),
      title: Text('สต๊อคใน WH'),
      onTap: () {
        setState(() {
          currentWidget = StockWH();
          titleAppBar = titleAppBars[3];
        });
        Navigator.pop(context);
      },
    );
  }

  Widget buildListTileSingOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          tileColor: Colors.red.shade700,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          title: Text(
            'ออกจากระบบ',
            style: MyStyle().titelH2(),
          ),
          onTap: () async {
            Navigator.pop(context);

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
                (route) => false);
          },
        ),
      ],
    );
  }

  Drawer buildDrawer() => Drawer(
        child: Column(
          children: [
            buildUserAccountsDrawerHeader(),
            showMenus.length == 0
                ? MyStyle().showProgress()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: showMenus.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        setState(() {
                          currentWidget = showWidgets[index];
                        });
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        showIcons[index],
                        size: 36,
                      ),
                      title: Text(showMenus[index]),
                    ),
                  ),
          ],
        ),
      );

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1.2,
          center: Alignment(-0.8, -0.8),
          colors: [Colors.white, MyStyle().darkBackgroud],
        ),
      ),
      currentAccountPicture: Image.asset('images/logo.png'),
      accountName: Text(name == null ? 'Name' : name),
      accountEmail: Text('Logined'),
    );
  }
}
