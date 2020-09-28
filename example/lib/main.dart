import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), title: 'Flutter Speed Dial Examples'));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  ScrollController scrollController;
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      quickActionWidget: QuickActionBox(
        actionTitles: ['Action', 'Action with longer text', 'Quick', 'Go!'],
      ),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => print('FIRST CHILD'),
          label: 'First Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
          label: 'Second Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => print('FIRST CHILD'),
          label: 'First Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
          label: 'Second Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Speed Dial')),
      body: buildBody(),
      floatingActionButton: buildSpeedDial(),
    );
  }
}

class QuickActionBox extends StatelessWidget {
  const QuickActionBox({Key key, @required this.actionTitles})
      : super(key: key);

  final List<String> actionTitles;

  @override
  Widget build(BuildContext context) {
    final quickActions = List<Widget>.from(actionTitles.map(
      (title) => QuickActionButton(title: title),
    ));

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 32,
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.height / 3 < 3 * 48) {
            return SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              child: Row(children: quickActions),
            );
          }
          return Wrap(
            clipBehavior: Clip.none,
            runAlignment: WrapAlignment.spaceEvenly,
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: quickActions,
          );
        },
      ),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  const QuickActionButton({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: MaterialButton(
        height: 48,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
            side: BorderSide(color: Theme.of(context).accentColor)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Attention'),
                content: Text('Proceed with "$title"?'),
                actions: [
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('YES'),
                    onPressed: () {
                      print(title);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        textTheme: ButtonTextTheme.accent,
        child: Text(title),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
