import 'package:flutter/material.dart';

class HistoryListCardWidget extends StatelessWidget {
  const HistoryListCardWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black54, fontSize: 17),
      ),
    );
  }
}
