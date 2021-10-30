import 'package:flutter/cupertino.dart';
import 'package:helpinghandsversion2/model/userStoryMeta.dart';

class Story {
  final String url;
  final Duration duration;
  final User user;

  const Story({
    required this.url,
    required this.duration,
    required this.user,
  });
}
