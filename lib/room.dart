import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class Room extends StatefulWidget {
  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  TextEditingController type = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController mony = TextEditingController();
  TextEditingController favoret = TextEditingController();

  File? file;
  ImagePicker image = ImagePicker();
  var url;
  var DesignerUrl;
  DatabaseReference? dbRefRome;
  DatabaseReference? dbRefUser;
  DatabaseReference? dbRefDesigner;
  DatabaseReference? dbRefDesign;
  @override
  void initState() {
    super.initState();
    dbRefRome = FirebaseDatabase.instance.ref().child('room');
    dbRefUser = FirebaseDatabase.instance.ref().child('account');
    dbRefDesigner = FirebaseDatabase.instance.ref().child('designer');
    dbRefDesign = FirebaseDatabase.instance.ref().child('design');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add room',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: 200,
                  width: 200,
                  child: file == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 90,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            getImage();
                          },
                        )
                      : MaterialButton(
                          height: 100,
                          child: Image.file(
                            file!,
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {
                            getImage();
                          },
                        )),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: type,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'type',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: size,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'size',
              ),
              maxLength: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: mony,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'mony',
              ),
              maxLength: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: favoret,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'favoret',
              ),
              maxLength: 10,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                // getImage();

                if (file != null) {
                  // OpretorWithFirebase.uploadFile(file!, name.text, number.text);
                  uploadFile();
                }
              },
              child: Text(
                "Add",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
              color: Colors.indigo[900],
            ),
          ],
        ),
      ),
    );
  }

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });

    // print(file);
  }

  uploadFile() async {
    try {
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("room_photo")
          .child("/${type.text}.jpg");
      var imagedesigner = FirebaseStorage.instance
          .ref()
          .child("designer_photo")
          .child("/${type.text}.jpg");
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      UploadTask taskDesigner = imagedesigner.putFile(file!);
      TaskSnapshot snapshotDesigner = await task;
      DesignerUrl = await snapshotDesigner.ref.getDownloadURL();

      if (url != null) {
        Map<String, String> OrderRoom = {
          'type': type.text,
          'size': size.text,
          'mony': mony.text,
          'favoret': favoret.text,
          'url': url,
        };
        Map<String, String> User = {
          'first': 'ahmed',
          'second': 'hamood',
          'addrss': 'address',
          'phone': '772684343',
          'email': 'ahmed@gmail.com',
          'password': 'passwodr',
        };
        Map<String, String> Designer = {
          'password': 'passwodr',
          'email': 'ahmed@gmail.com',
          'fullname': 'full name',
          'username': 'username',
          'phone': '772684343',
          'qualification': 'qualification',
        };
        Map<String, String> Design = {
          'details': 'details',
          'photoOfRome': DesignerUrl,
          'furumiturestores': 'furumiturestores',
        };

        dbRefRome!.push().set(OrderRoom).whenComplete(() {
          print("Contact ...............");
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => HomeRome(),
          //   ),
          // );
        });
        dbRefUser!.push().set(User).whenComplete(() {
          print("User ...............");
        });
        dbRefDesigner!.push().set(Designer).whenComplete(() {
          print("User ...............");
        });
        dbRefDesign!.push().set(Design).whenComplete(() {
          print("User ...............");
        });
        
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
