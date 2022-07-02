import 'package:flutter/material.dart';
import 'package:we_slide/we_slide.dart';

class SearchSheet extends StatelessWidget {
  const SearchSheet({
    Key? key,
    required WeSlideController controller,
  }) : _controller = controller, super(key: key);

  final WeSlideController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _controller.hide();
                  },
                  icon: Icon(Icons.close)),
              SizedBox(width: 50),
              Text(
                "Your Trip",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              )
            ],
          ),
          Divider(),
          TextField()
        ],
      ),
    );
  }
}