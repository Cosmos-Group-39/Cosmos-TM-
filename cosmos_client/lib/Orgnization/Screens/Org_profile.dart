import 'dart:io';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/FeedBack/Models/feedbackModels.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_MembersAdd.dart';
import 'package:cosmos_client/Orgnization/Models/orgModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrgPro extends StatefulWidget {
  final OrganizationModel item;
  // final Function(File?) onProfilePicChanged;
  const OrgPro({Key? key, required this.item}) : super(key: key);

  @override
  State<OrgPro> createState() => _OrgProState();
}

class _OrgProState extends State<OrgPro> {
  File? _profilePic;
  late double _rating = 1;
  double _initialRating = 1;
  List<ReviewModel> _reviews = [];

  @override
  void initState() {
    super.initState();
    _profilePic = File(widget.item.pic!);
    _reviews.add(
        ReviewModel(rating: 4, reviewer: 'Tim David', organization: 'new'));
  }

  // void delOrg() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Icon(
  //           Icons.warning_amber_sharp,
  //           size: 60.0,
  //           color: Colors.deepOrange,
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: const [
  //             Text(
  //               'Are You Sure ?',
  //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 17),
  //               child: Text(
  //                 'You want to delete this Organization !',
  //                 style: TextStyle(fontSize: 13),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               cardsx.remove(widget.item.cardID);
  //               print(widget.item.cardName);
  //               Navigator.pop(context);
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Delete'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kDefaultIconLightColor,
              )),
          title: Text(
            widget.item.name,
            style: kAppBarTitle,
          ),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: null,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 80,
                  // backgroundImage:
                  //     _profilePic != null ? FileImage(_profilePic!) : null,
                ),
                const SizedBox(height: 20),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrgAddMembers()));
                      },
                      icon: const Icon(Icons.add_circle),
                      label: const Text('Add Members'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Create Workflows'),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                const Text('Description',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    )),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(widget.item.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    )),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: _reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                SizedBox(width: 8),
                                Text(this._reviews[0].reviewer),
                              ],
                            ),
                            onTap: null,
                          ),
                          ratingBar(),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Rating Bar
  Widget ratingBar() {
    return RatingBar.builder(
      initialRating: _initialRating,
      unratedColor: Colors.grey,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return const Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return const Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return const Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return const Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return Container();
        }
      },
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
