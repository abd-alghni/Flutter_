import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../Helpers/colors.dart';
import '../../Services/Dbhelper.dart';
import '../../Widgets/CustomText.dart';
import '../../Widgets/CustomTextField.dart';
import '../Home/Home.dart';

class NotesForm extends StatefulWidget {
  late Map<String, dynamic>? data;
  NotesForm({this.data});
  @override
  State<NotesForm> createState() => _NotesFormState();
}

class _NotesFormState extends State<NotesForm> {
  int currentcolor = 0xFF1321E0;
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  Future<void> _addItem() async {
    var data = await Dbhelper.create(title.text, subtitle.text, currentcolor);
    log("$data");
    title.text = "";
    subtitle.text = "";
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Home()),
        (Route<dynamic> route) => false).then((value) => setState(() {}));
  }

  Future<void> Update() async {
    await Dbhelper.update(
        widget.data!['id'], title.text, subtitle.text, currentcolor);
    title.text = "";
    subtitle.text = "";
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Home()),
        (Route<dynamic> route) => false).then((value) => setState(() {}));
  }

  Future<void> delete() async {
    await Dbhelper.delete(widget.data!['id']);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Home()),
        (Route<dynamic> route) => false).then((value) => setState(() {}));
  }

  @override
  void initState() {
    if (widget.data != null) {
      title.text = widget.data!['title'];
      subtitle.text = widget.data!['description'];
      currentcolor = widget.data!['color'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(currentcolor),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  title: widget.data != null ? "Edit Note" : "Add Note",
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Color(currentcolor),
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.share),
                                  onTap: () {
                                    Share.share(widget.data!['description'],
                                        subject: widget.data!['title']);
                                  },
                                  title: Text('Share with your Friends'),
                                ),
                                ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                    onTap: () {
                                      delete();
                                    }),
                                ListTile(
                                  leading: Icon(Icons.copy),
                                  title: Text('Deplicate'),
                                  onTap: () {
                                    if (widget.data != null) {
                                      _addItem();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: colors.Colorlist.map((e) =>
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentcolor = e;
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey.shade400),
                                                color: Color(e),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: currentcolor == e
                                                ? Center(
                                                    child: Icon(
                                                    Icons.check,
                                                    size: 25,
                                                  ))
                                                : Container(),
                                          ),
                                        )).toList(),
                                  ),
                                ))
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (widget.data != null) {
                          Update();
                        } else {
                          if (title != null) _addItem();
                        }
                      },
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 25,
                      )),
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomTextField(
                text: "  Title",
                controller: title,
                color: Color(currentcolor),
                inputcolor: Color(currentcolor),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: size.height * 0.15,
                child: CustomTextField(
                  text: "  Descrption",
                  controller: subtitle,
                  color: Color(currentcolor),
                ),
              )
            ],
          ),
        ));
  }
}
