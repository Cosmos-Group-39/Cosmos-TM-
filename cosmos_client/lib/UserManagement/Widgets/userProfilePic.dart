import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePictureWidget extends StatefulWidget {
  final void Function(String? imagePath) onImageSelected;
  const UserProfilePictureWidget({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  _UserProfilePictureWidgetState createState() =>
      _UserProfilePictureWidgetState();
}

class _UserProfilePictureWidgetState extends State<UserProfilePictureWidget> {
  File? _imageFile;

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
      widget.onImageSelected(pickedImage.path);
    }
  }

  void _resetProfilePicture() {
    setState(() {
      _imageFile = null;
      widget.onImageSelected(null); // Clear the selected image path
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('Take a picture'),
                      onTap: () {
                        pickImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(color: kPrimaryColor.withOpacity(0.5)),
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Import from device'),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Add a profile photo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey[300],
              child: _imageFile == null
                  ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
