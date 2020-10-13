import 'package:canvas/cursor.dart';
import 'package:canvas/whiteboard.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget leading;
  Color selectedColor;
  Function onPenTapped;
  Function onEraserTapped;
  Function onColorTapped;
  final Function onUndo;
  final Function onRedo;
  final BuildContext context;
  final List<Widget> actions;

  Widget colorBoxWidget() {
    return Container(color: selectedColor, width: 35, height: 35);
  }

  AppBarWidget(
      {Key key,
      this.title,
      this.leading,
      this.context,
      this.actions,
      this.onColorTapped,
      this.selectedColor,
      this.onEraserTapped,
      this.onPenTapped, this.onUndo, this.onRedo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Offset>>(
        stream: offSetController.offset.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Offset>> snapshot) {
          return Container(
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Cursor(
                  cursorStyle: Cursor.pointer,
                  child: Wrap(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.undo,
                            color: Colors.white,
                          ),
                          onPressed: onUndo
                          // () {
                          //   List<Offset> newList = [];
                          //   if (snapshot.data != null) {
                          //     List<Offset> offsetList = [];
                          //     offsetList = snapshot.data;
                          //     for (int i = 0; i < offsetList.length - 1; i++) {
                          //       newList.add(offsetList[i]);
                          //     }
                          //   }
                          //   offSetController.offset.sink.add(newList);
                          //   print('undo');
                          // }
                          ),
                      IconButton(
                          icon: Icon(
                            Icons.redo,
                            color: Colors.white,
                          ),
                          onPressed: onRedo),
                    ],
                  ),
                ),
                Cursor(
                  cursorStyle: Cursor.pointer,
                  child: Wrap(
                    children: <Widget>[
                      GestureDetector(
                        onTap: onColorTapped,
                        child: Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: colorBoxWidget()),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.brush,
                            color: Colors.white,
                          ),
                          onPressed: onPenTapped),
                      IconButton(
                          icon: Icon(
                            Icons.radio_button_checked,
                            color: Colors.white,
                          ),
                          onPressed: onEraserTapped),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
