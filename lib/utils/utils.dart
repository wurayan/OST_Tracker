import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/genero_chip.dart';
import 'package:ost_tracker_og/components/tag_chip.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/models/tag_model.dart';

List<InlineSpan> generoBuilder(List<Genero> generos) {
  return generos
      .map((e) => WidgetSpan(
              child: GeneroChip(
            genero: e,
          )))
      .toList();
}

List<InlineSpan> tagBuilder(List<Tag> tags) {
  return tags
      .map((e) => WidgetSpan(
              child: TagChip(
            tag: e,
          )))
      .toList();
}

List<Widget> tagBuilderWidget(List<Tag> tags) {
  return tags
      .map((e) => TagChip(
            tag: e,
          ))
      .toList();
}

List<Widget> generoBuilderWidget(List<Genero> generos) {
  return generos
      .map((e) => GeneroChip(
            genero: e,
          ))
      .toList();
}

List<Color> tagColors = [
  const Color(0xff79BAFF),
  const Color(0xffD99DFF),
  const Color(0xffFF8DE3),
  const Color(0xffFF99B2),
  const Color(0xffFF9999),
  const Color(0xffFF9F56),
  // const Color(0xffFFF064),
  // const Color(0xffE0FF6F),
  // const Color(0xffB1FF6D),
  // const Color(0xff6DFF80),
  // const Color(0xff8AFFD6),
  // const Color(0xff8AFFFB),
  const Color(0xff42CDFF),
  const Color(0xffA5B9FF),
  const Color(0xffB9B5FF),
];

getRandomColor(List<Color> colors) => colors[Random().nextInt(colors.length)];
