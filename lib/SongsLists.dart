
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/OutlineBtn.dart';
import 'package:topi/constants.dart';

class SongsLists extends StatefulWidget {
  var index, selected,songsList,pVisible,pClick;
  Function clickIcon;

  SongsLists(
      {required this.index,
        required  this.selected,
        required this.songsList,
        required this.pVisible,
        required this.clickIcon,
        required this.pClick,
       });

  @override
  _SongsListsState createState() => _SongsListsState();
}

class _SongsListsState extends State<SongsLists> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      child: Card(
        shape: widget.selected[widget.index] == true
            ? new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.white, width: 4.0),
            borderRadius: BorderRadius.circular(20.0))
            : new RoundedRectangleBorder(
            side: new BorderSide(width: 1.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                Color(int.parse(
                    '0xff${widget.songsList[widget.index]['color'].toString().split(',').elementAt(0).substring(1, widget.songsList[widget.index]['color'].toString().split(',').elementAt(0).length)}')),
                Color(int.parse(
                    '0xff${widget.songsList[widget.index]['color'].toString().split(',').elementAt(1).substring(1, widget.songsList[widget.index]['color'].toString().split(',').elementAt(0).length)}')),
                Color(int.parse(
                    '0xff${widget.songsList[widget.index]['color'].toString().split(',').elementAt(2).substring(1, widget.songsList[widget.index]['color'].toString().split(',').elementAt(0).length)}')),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  widget.clickIcon(widget.index),
                  size: 40.0,
                  color: Colors.white,
                  /* onPressed: () {
                                                      setState(() {
                                                        if (isClick.contains(true)) {
                                                          if (isClick[widget.index] == true) {
                                                            isClick[index] = false;
                                                            print('stop');
                                                            stop();
                                                          } else {
                                                            isClick = List.filled(widget.songsList.length, false);
                                                            isClick[index] = true;
                                                            print('play isclick false');                                                                                       play(widget.songsList[index]['audio']);
                                                          }
                                                        } else {
                                                          isClick[index] = true;
                                                          print('play isClick not contain');
                                                          play(widget.songsList[index]['audio']);
                                                        }
                                                      });
                                                    },*/
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Title: ${widget.songsList[widget.index]['video_name']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: widget.pVisible,
                    child:IconButton(
                        onPressed: widget.pClick, icon: FaIcon(FontAwesomeIcons.crown,color: Colors.yellow,
                    size: 20.0,)) /*UnicornOutlineButton(
                      strokeWidth: 1,
                      radius: 10,
                      gradient: LinearGradient(colors: [Colors.cyan, Colors.deepOrangeAccent]),
                      child:  Text('Premium',style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()..shader = linearGradient
                      ),),
                      onPressed: widget.pClick,
                    ),*/
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
