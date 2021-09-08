import 'dart:convert';

import 'package:flutter/painting.dart';
import 'utilities.dart';
import 'package:random_color/random_color.dart';

import 'eyes/eyes_main.dart';
import 'face/face_main.dart';
import 'mouth/mouth_main.dart';
import 'sides/sides_main.dart';
import 'texture/texture_main.dart';
import 'top/top_main.dart';

class Bottt {
  Color color;
  EyeType eye;
  FaceType face;
  MouthType mouth;
  SideType side;
  TextureType texture;
  TopType top;

  Bottt({
    required this.color,
    required this.eye,
    required this.face,
    required this.mouth,
    required this.side,
    required this.texture,
    required this.top,
  });

  Bottt.random({
    Color? color,
    EyeType? eye,
    FaceType? face,
    MouthType? mouth,
    SideType? side,
    TextureType? texture,
    TopType? top,
  }) : this(
          color: color ??
              RandomColor().randomColor(
                  colorSaturation: ColorSaturation.mediumSaturation),
          eye: eye ?? pickRandomItem(EyeType.values),
          face: face ?? pickRandomItem(FaceType.values),
          mouth: mouth ?? pickRandomItem(MouthType.values),
          side: side ?? pickRandomItem(SideType.values),
          texture: texture ?? pickRandomItem(TextureType.values),
          top: top ?? pickRandomItem(TopType.values),
        );

  Map<String, dynamic> toJson() => {
        'color': color?.value,
        'eye': enumToJson(eye),
        'face': enumToJson(face),
        'mouth': enumToJson(mouth),
        'side': enumToJson(side),
        'texture': enumToJson(texture),
        'top': enumToJson(top),
      };

  Bottt.fromJson(Map<String, dynamic> json)
      : color = Color(json['color']),
        eye = enumFromJson(EyeType.values, json['eye']),
        face = enumFromJson(FaceType.values, json['face']),
        mouth = enumFromJson(MouthType.values, json['mouth']),
        side = enumFromJson(SideType.values, json['side']),
        texture = enumFromJson(TextureType.values, json['texture']),
        top = enumFromJson(TopType.values, json['top']);

  String serialize() {
    return json.encode(this.toJson());
  }

  Bottt copy() {
    return Bottt(
        color: this.color,
        eye: this.eye,
        face: this.face,
        mouth: this.mouth,
        side: this.side,
        texture: this.texture,
        top: this.top);
  }
}
