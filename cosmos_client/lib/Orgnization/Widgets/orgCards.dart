import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_profile.dart';
import 'package:cosmos_client/Orgnization/Screens/Your_Org.dart';
import 'package:cosmos_client/Orgnization/Models/orgModels.dart';
import 'package:cosmos_client/Orgnization/Widgets/Profile_Pic.dart';
import 'package:flutter/material.dart';

class OrgCard extends StatefulWidget {
  final Function(OrganizationModel) onEdit;
  final Function(String) onDelete;
  final OrganizationModel item;

  const OrgCard(
      {Key? key,
      required this.item,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  @override
  State<OrgCard> createState() => _OrgCardState();
}

class _OrgCardState extends State<OrgCard> {
  TextEditingController _cardNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late String newprofilePic;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void editCard() {
    String cardName = _cardNameController.text.trim();
    String description = _descriptionController.text.trim();

    OrganizationModel editedItem = OrganizationModel(
      cardID: widget.item.cardID,
      cardName: cardName,
      description: description,
      profilePic: newprofilePic,
      members: [],
    );

    widget.onEdit(editedItem);
  }

  //Delete Organization
  deleteOrg() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          title: const Icon(
            Icons.delete,
            size: 60.0,
            color: Colors.green,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are You Sure ?',
                  style: kAlertBoxTopicTextStyle,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 17),
                  child: Text(
                    'You want to delete the Orgnization !',
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle,
                onPressed: () {
                  widget.onDelete(widget.item.cardID);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: kAlertBoxButtonTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  //Update Card
  changeCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Update Organization',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.edit_document,
                  size: 60.0,
                  color: Colors.green,
                ),
                const SizedBox(height: 10),
                Divider(thickness: 3),
                //update profile pic when it is need
                ProfilePictureWidget(
                  onImageSelected: (String? imagePath) {
                    setState(() {
                      newprofilePic = imagePath ?? widget.item.profilePic;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Divider(thickness: 3),
                TextField(
                  controller: _cardNameController,
                  decoration: const InputDecoration(
                    hintText: 'Organizaton Name',
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle,
                onPressed: () {
                  editCard();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Confirm',
                  style: kAlertBoxButtonTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrgPro(
              item: OrganizationModel(
                cardID: uuid.v1(),
                cardName: widget.item.cardName,
                description: widget.item.description,
                profilePic: widget.item.profilePic,
                members: [],
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kPrimaryColor, kSecondaryColor],
            ),
          ),
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 35,
                backgroundImage: widget.item.profilePic != ''
                    ? FileImage(File(widget.item.profilePic))
                    : null,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  widget.item.cardName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kBackgroundColor,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
              const SizedBox(width: 100),
              IconButton(
                  onPressed: changeCard,
                  icon: const Icon(Icons.create, color: kBackgroundColor)),
              IconButton(
                  onPressed: deleteOrg,
                  icon: const Icon(Icons.delete, color: kBackgroundColor))
            ],
          ),
        ),
      ),
    );
  }
}
