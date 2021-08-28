import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'IconClass/custom_icons_icons.dart';

class MyIndormation extends StatelessWidget {
  final _urlTwitter = 'https://twitter.com/sahinadirhan';
  final _urlGithub = 'https://github.com/creatornadiran';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage("assets/me.jpg"),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
            "Hi, my name is Nadirhan and I'm a 2nd year Computer Engineering student in Turkey. I am interested in machine learning and mobile development."),
        SizedBox(
          height: 15,
        ),
        Text("To contact me:"),
        SizedBox(
          height: 15,
        ),
        FloatingActionButton.extended(
          onPressed: () {
            _launchURL(_urlTwitter);
          },
          label: Text("Twitter"),
          icon: Icon(CustomIcons.twitter),
        ),
        SizedBox(
          height: 15,
        ),
        FloatingActionButton.extended(
          onPressed: () {
            _launchURL(_urlGithub);
          },
          label: Text("Github"),
          icon: Icon(CustomIcons.github),
        )
      ],
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
