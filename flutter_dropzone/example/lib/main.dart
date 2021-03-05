import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DropzoneViewController controller1;
  DropzoneViewController controller2;
  String message1 = 'Drop something here';
  String message2 = 'Drop something here';
  bool highlighted1 = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Dropzone example'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: highlighted1 ? Colors.red : Colors.transparent,
                  child: Stack(
                    children: [
                      buildZone1(context),
                      Center(child: Text(message1)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    buildZone2(context),
                    Center(child: Text(message2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) {
            controller1 = ctrl;
            print(controller1.viewId);
          },
          onLoaded: () => print('Zone 1 loaded'),
          onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlighted1 = true);
            print('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlighted1 = false);
            print('Zone 1 left');
          },
          onDrop: (ev) {
            print('Zone 1 drop: ${ev.name}');
            setState(() {
              message1 = '${ev.name} dropped';
              highlighted1 = false;
            });
          },
          onImgDrop: (event) {
            print('Zone 1 onImgDrop: $event');
            setState(() {
              message1 = '${event} dropped';
              highlighted1 = false;
            });
          },
        ),
      );

  Widget buildZone2(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.move,
          onCreated: (ctrl) {
            controller2 = ctrl;
            print(controller2.viewId);
          },
          onLoaded: () => print('Zone 2 loaded'),
          onError: (ev) => print('Zone 2 error: $ev'),
          onHover: () => print('Zone 2 hovered'),
          onLeave: () => print('Zone 2 left'),
          onDrop: (ev) {
            print('Zone 2 drop: ${ev.name}');
            setState(() {
              message2 = '${ev.name} dropped';
            });
          },
          onImgDrop: (event) {
            print('Zone 2 onImgDrop: $event');
            setState(() {
              message2 = '${event} dropped';
            });
          },
        ),
      );
}
