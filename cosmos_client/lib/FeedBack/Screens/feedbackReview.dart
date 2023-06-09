import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/FeedBack/Screens/ratedscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackReview extends StatefulWidget {
  const FeedbackReview({super.key});

  @override
  State<FeedbackReview> createState() => _FeedbackReviewState();
}

class _FeedbackReviewState extends State<FeedbackReview> {
  double _initialRating = 1;
  String UserId = '';
  String? description;

  @override
  void initState() {
    super.initState();
  }

  late double _rating = 1;

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            'Rate Us',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(color: kPrimaryColor, width: 3)),
      scrollable: true,
      titlePadding: const EdgeInsets.all(10.0),
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Divider(thickness: 2, color: kPrimaryColor),
          const SizedBox(height: 20.0),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ratingBar(), // Rating bar
          ),
          const SizedBox(height: 20.0),
          Text(
            'Rating: $_rating',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              maxLength: 400,
              maxLines: null,
              keyboardType: TextInputType.text,
              scrollController: ScrollController(keepScrollOffset: true),
              decoration: InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.start,
                hintText: 'What are your thoughts?',
                label: const Text(
                  'Feedback',
                  style: TextStyle(
                      color: kPrimaryColor, fontStyle: FontStyle.italic),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kPrimaryColor)),
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RatedScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      backgroundColor: kPrimaryColor),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: const Text(
                      'Later',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // print(comment);
                    // try {
                    //   var url = localhost + '/feed';
                    //   final response = await http.post(
                    //     Uri.parse(url),
                    //     headers: {'Content-Type': 'application/json'},
                    //     body: jsonEncode({
                    //       'uid': UserId,
                    //       'rating': _rating.toDouble(),
                    //       'comment': comment,
                    //       'dt': DateTime.now().toString()
                    //     }),
                    //   );
                    //   if (response.statusCode == 200) {
                    //     print('${response.body}');
                    //     print('${response.statusCode}');
                    //   } else {
                    //     print('${response.body}');
                    //   }
                    // } catch (e) {
                    //   print(e);
                    // }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RatedScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      backgroundColor: kPrimaryColor),
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
