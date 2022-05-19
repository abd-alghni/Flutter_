import 'package:flutter/material.dart';
import 'package:note_lab/Services/Dbhelper.dart';
import 'package:note_lab/Views/Notes/NotesForm.dart';
import '../../Helpers/colors.dart';
import '../../Widgets/CustomText.dart';
import '../../Widgets/NoteWidgets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isloading = false;
  void getData() async {
    isloading = true;
    final data = await Dbhelper.getall();
    setState(() {
      _newItem = [];
      _newItem = data;
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Map<String, dynamic>> _newItem = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primarycolor,
        title: CustomText(
          title: "My Notes",
          size: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      body: _newItem.length != 0
          ? isloading
              ? CircularProgressIndicator(
                  color: colors.primarycolor,
                )
              : RefreshIndicator(
                  onRefresh: () async => getData(),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: ListView.separated(
                      itemCount: _newItem.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NotesForm(
                                    data: _newItem[index],
                                  )));
                        },
                        child: NoteWidgets(
                          data: _newItem[index],
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 15,
                      ),
                    ),
                  ),
                )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.32,
                  width: size.width * 0.95,
                  child: Image.asset(
                    'assets/note.png',
                    color: colors.primarycolor,
                  ),
                ),
                CustomText(
                  title: "No Notes :(",
                  size: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  title: "You have no task to do",
                  size: 15,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  colors: [colors.primarycolor, Colors.purple],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
                child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ))),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotesForm(
                    data: null,
                  )));
        },
      ),
    );
  }
}
