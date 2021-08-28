import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class classifyPage extends StatefulWidget {
  const classifyPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<classifyPage> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  File? _image;
  List? _output;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "What Type Is Your Shark?",
        ),
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 400,
                    width: 400,
                    margin: EdgeInsets.all(25),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xff000070),
                        width: 10,
                      ),
                    ),
                    child: _image == null
                        ? Image(
                            image: AssetImage("assets/fin.png"),
                            width: 500,
                          )
                        : Image.file(_image!),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff000070), width: 5),
                    ),
                    child: _output != null && _output!.length > 0
                        ? Center(
                            child: Text(
                              "${(_output![0]["label"]).split(" ")[1]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "FredokaOne"),
                            ),
                          )
                        : Text(
                            "",
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Please choose a source'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    chooseImage(true);
                    return Navigator.pop(context, 'From Gallery');
                  },
                  child: const Text('From Gallery'),
                ),
                TextButton(
                  onPressed: () {
                    chooseImage(false);
                    return Navigator.pop(context, 'Take a photo');
                  },
                  child: const Text('Take a photo'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        },
        label: Text("Add Photo"),
        icon: Icon(Icons.image),
      ),
    );
  }

  chooseImage(bool gallery) async {
    var image = await (gallery
        ? (_picker.pickImage(source: ImageSource.gallery))
        : (_picker.pickImage(source: ImageSource.camera)));
    if (image == null) return null;
    setState(() {
      _isLoading = true;
      _image = File(image.path);
    });
    print("Aaaaa");
    print(File(image.path));
    classifyImage(image);
  }

  classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.5,
    );
    setState(() {
      _isLoading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/vww_96_grayscale_quantized.tflite",
        labels: "assets/labels.txt");
  }
}
