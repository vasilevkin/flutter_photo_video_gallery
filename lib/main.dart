import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Photo and Video';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: PhotoAndVideo(),
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Next page'),
        ),
        body: const Center(
          child: Text(
            'This is the next page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}

class PhotoAndVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoAndVideoState();
  }
}

class PhotoAndVideoState extends State<PhotoAndVideo> {
  File selectedGalleryAsset;
  File selectedCameraAsset;

  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      selectedGalleryAsset = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        print("Asset from gallery: " + selectedGalleryAsset.path);
      });
    }

    imageSelectorGalleryVideo() async {
      selectedGalleryAsset = await ImagePicker.pickVideo(
        source: ImageSource.gallery,
      );
      setState(() {
        print("Video Asset from gallery: " + selectedGalleryAsset.path);
      });
    }

    imageSelectorCamera() async {
      selectedCameraAsset = await ImagePicker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        print("Asset from camera: " + selectedCameraAsset.path);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo and Video'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Next page',
            onPressed: () {
              openPage(context);
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.green,
                child: Text('Select Image from Gallery'),
                onPressed: imageSelectorGallery,
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text('Play Video from Gallery'),
                onPressed: imageSelectorGalleryVideo,
              ),
              MaterialButton(
                color: Colors.yellow,
                child: Text('Take Image or Video from Camera'),
                onPressed: imageSelectorCamera,
              ),
              showSelectedAsset(selectedGalleryAsset),
              showSelectedAsset(selectedCameraAsset)
            ],
          );
        },
      ),
    );
  }

  Widget showSelectedAsset(File file) {
    return Center(
      child: SizedBox(
        height: 250.0,
        width: 350.0,
        child: Center(
          child: file == null
              ? Text('Please select photo or video')
              : Image.file(file),
        ),
      ),
    );
  }
}
