import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int rating;
  // final void Function(int) onRatingChanged;

  StarRating({required this.rating});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        int rating = index + 1;

        return Icon(
          rating <= widget.rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
}