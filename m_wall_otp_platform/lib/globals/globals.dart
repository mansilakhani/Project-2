import 'package:flutter/material.dart';

List<Map> weblist = [
  {
    'name': 'Netflix',
    'url': 'https://www.netflix.com/',
    'route': 'netflix',
    'color': Colors.red,
  },
  {
    'name': 'Amazon Prime',
    'url': 'https://www.amazon.in/',
    'route': 'amazon',
    'color': Colors.amber,
  },
  {
    'name': 'Disney+Hotstar',
    'url': 'https://www.hotstar.com/in',
    'route': 'disneyplushotstar',
    'color': const Color(0xff0e1a4c),
  },
  {
    'name': 'Sony LIV',
    'url': 'https://www.sonyliv.com/',
    'route': 'sonyliv',
    'color': const Color(0xfffa8b00),
  },
  {
    'name': 'Prime Video',
    'url': 'https://www.primevideo.com/',
    'route': 'primevideo',
    'color': Color(0xff3cacc4),
  },
];

class globals {
  static String searchtext = "";
}
