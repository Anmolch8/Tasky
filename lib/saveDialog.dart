import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/dataprovider.dart';
import 'package:todo_app/model.dart';

Future<dynamic> SaveDialog(
    BuildContext context,
    Size media,
    TextEditingController titlecontroller,
    TextEditingController detailcontroller,
    String? timest,
    {int a = -1}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: media.height / 2.3,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: media.height / 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(media.height / 100)),
                TextField(
                  maxLength: 25,
                  controller: titlecontroller,
                  cursorColor: Color.fromARGB(255, 124, 115, 84),
                  decoration: InputDecoration(
                      hintText: "Title",
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 124, 115, 84)))),
                  style: TextStyle(
                      fontSize: media.height / 30, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.all(media.height / 100)),
                TextField(
                    maxLength: 40,
                    controller: detailcontroller,
                    cursorColor: Color.fromARGB(255, 124, 115, 84),
                    decoration: InputDecoration(
                        hintText: "Brief",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 124, 115, 84)))),
                    style: TextStyle(
                        fontSize: media.height / 30,
                        fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.all(media.height / 100)),
                Consumer<DataProvider>(builder: (context, value, child) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 129, 172, 135),
                          fixedSize: Size(170, 50)),
                      onPressed: () {
                        String title = titlecontroller.text;
                        String detail = detailcontroller.text;

                        data d = data(
                            title: title,
                            detail: detail,
                            iscompleted: false,
                            timestamp: timest);
                        if (a == -1) {
                          value.ad(d);
                          Navigator.pop(context);
                        } else {
                          value.ed(a, d);
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.save),
                          Padding(
                              padding: EdgeInsets.only(left: media.width / 20)),
                          Text(
                            "Save",
                            style: TextStyle(fontSize: media.height / 20),
                          )
                        ],
                      ));
                })
              ],
            ),
          ),
        );
      });
}
