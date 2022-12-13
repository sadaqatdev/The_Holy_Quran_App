import 'package:flutter/material.dart';

class DrawerUtils {
  static const List items = [
    {
      'title': 'Surah Index',
      'icon': Icons.format_list_numbered_outlined,
      'route': '/surahIndex',
    },
    {
      'title': 'Juz Index',
      'icon': Icons.list,
      'route': '/juzIndex',
    },
    {
      'title': 'Bookmarks',
      'icon': Icons.bookmark_outline,
      'route': '/bookmarks',
    },
    {
      'title': 'Help Guide',
      'icon': Icons.help_outline,
      'route': '/help',
    },
    {
      'title': 'About',
      'icon': Icons.info_outline,
      'route': '/about',
    },
    {
      'title': 'Share App',
      'icon': Icons.share_outlined,
      'route': '/share',
    },
  ];
}
