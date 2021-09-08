import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'IconClass/custom_icons_icons.dart';

class MyIndormation extends StatelessWidget {
  final _urlTwitter = 'https://twitter.com/sahinadirhan';
  final _urlGithub = 'https://github.com/creatornadiran';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Image(
          image: AssetImage("assets/me.jpg"),
          height: 0.3 * height,
          width: 0.3 * height,
        ),
        SizedBox(
          height: 0.01 * height,
        ),
        Text(
            "Hi, my name is Nadirhan and I'm a 2nd year Computer Engineering student in Turkey. I am interested in machine learning and mobile development."),
        SizedBox(
          height: 0.01 * height,
        ),
        Text("To contact me:"),
        SizedBox(
          height: 0.01 * height,
        ),
        FloatingActionButton.extended(
          onPressed: () {
            _launchURL(_urlTwitter);
          },
          label: Text("Twitter"),
          icon: Icon(CustomIcons.twitter),
        ),
        SizedBox(
          height: 0.01 * height,
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
