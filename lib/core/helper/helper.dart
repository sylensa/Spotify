import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
const String clientId = "3af8e17840684c5bb3325a5e8b8e808d";
const String clientSecret = "e46b037b7f76416ca7e3ac9676f557f7";
final deviceType = getDeviceType();
enum DeviceType { Phone, Tablet }

DeviceType getDeviceType() {
  final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
  return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
}

List<BoxShadow> elevation({required Color color, required int elevation}) {
  return [
    BoxShadow(
        color: color.withOpacity(0.6),
        offset: const Offset(0.0, 4.0),
        blurRadius: 3.0 * elevation,
        spreadRadius: -1.0 * elevation),
    BoxShadow(
        color: color.withOpacity(0.44),
        offset: const Offset(0.0, 1.0),
        blurRadius: 2.2 * elevation,
        spreadRadius: 1.5),
    BoxShadow(
        color: color.withOpacity(0.12),
        offset: const Offset(0.0, 1.0),
        blurRadius: 4.6 * elevation,
        spreadRadius: 0.0),
  ];
}

noInternetConnection({String message = "No Internet Connection"}) {
  return  Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
    ),
    child:  Center(
        child: appText(
            message,
          size: 16,
            weight: FontWeight.w700,
            color: Colors.black,
        )),
  );
}

Widget displayImage(imagePath, {double radius = 30.0, double? height, double? width}) {

  return CachedNetworkImage(
      imageUrl: "$imagePath",
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0
            ? Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: 2* radius ,
          height: 2* radius ,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26
          ),

        )
            : Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: radius ,
          height: radius ,
          decoration:  BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.withOpacity(0.1))
          ),

        );
      },
      errorWidget: (context, url, error) {
        return radius > 0
            ? Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
                width: radius * 2,
                height: radius * 2,
                decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                  border: Border.all(color: Colors.grey[100]!),
                  image: const DecorationImage(image: AssetImage('assets/images/strade_base_logo.jpg'))
                ),

              )
            : const Image(
                image: AssetImage('assets/images/strade_base_logo.jpg'),
              );
      },
      imageBuilder: (context, image) {
        return radius > 0
            ? CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image,
                radius: radius,
              )
            : Image(
                image: image,
                fit: BoxFit.cover,
              );
      });
}

Widget appText(String? word,
    {double size = 14,
    FontWeight weight = FontWeight.w500,
    Color color = Colors.black,
    TextAlign align = TextAlign.left,
    int? maxLines = 5,
    double? lHeight = 1.2,
    double? decorationThickness = 1,
    String family = 'Proxima',
    FontStyle style = FontStyle.normal,
      TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration textDecoration = TextDecoration.none,
    int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: align,


    style: TextStyle(
      decoration: textDecoration,
      decorationThickness:decorationThickness ,
      height: lHeight,
      fontStyle: style,
      color: color,
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
      shadows:
          shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

TextStyle appStyle({
    double size = 16,
    double? height,
    Color? col =  Colors.black,
    FontWeight weight = FontWeight.w400,
    double? decorationThickness = 1,
    String family = 'Proxima',
    FontStyle style = FontStyle.normal,
    TextDecoration textDecoration = TextDecoration.none,
    }) {
  return TextStyle(
      fontFamily: family, fontWeight: weight, fontSize: size, color: col,decoration: textDecoration,decorationThickness: decorationThickness,height:height );
}

appWidth(context) {
  return MediaQuery.of(context).size.width;
}

appHeight(context) {
  return MediaQuery.of(context).size.height;
}

Future<bool> clearPrefs() async {
  var sp = await SharedPreferences.getInstance();
  sp.clear();
  return true;
}

getInDays(DateTime timestamp){
  double days = timestamp.difference(DateTime.now()).inHours/24;

  if(days.toInt() == 0){
    return "Today";
  }else if(days.toInt() == 1){
    return "Tomorrow";
  }else if(days.toInt() == 2){
    return "In 2days";
  }else if(days.toInt() == 3){
    return "In 3days";
  }else if(days.toInt() == 4){
    return "In 4days";
  }else{
    return DateFormat.yMMMEd().format(timestamp);
  }



}

Future<bool> setPref(key, value, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  print("Setting $type pref $key to $value...");
  switch (type) {
    case 'string':
      sp.setString(key, value);
      break;
    case 'bool':
      sp.setBool(key, value);
      break;
    case 'int':
      sp.setInt(key, value);
      break;
    case 'list':
      List<String> ls = value;
      sp.setStringList(key, ls);
      break;
  }
  return true;
}

Future<dynamic> getPref(key, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  switch (type) {
    case 'string':
      return sp.getString(key);
      break;
    case 'bool':
      return sp.getBool(key);
      break;
    case 'list':
      List<String> aList = [];
      List<String>? data = sp.getStringList(key);
      if (data != null) {
        aList = data;
        return aList;
      } else {
        return aList;
      }
      break;
  }
}

EdgeInsets noPadding() {
  return EdgeInsets.zero;
}

EdgeInsets appPadding(double size) {
  return EdgeInsets.all(size);
}

EdgeInsets topPadding(double size) {
  return EdgeInsets.only(top: size);
}

EdgeInsets bottomPadding(double size) {
  return EdgeInsets.only(bottom: size);
}

EdgeInsets leftPadding(double size) {
  return EdgeInsets.only(left: size);
}

EdgeInsets rightPadding(double size) {
  return EdgeInsets.only(right: size);
}

EdgeInsets horizontalPadding(double size) {
  return EdgeInsets.symmetric(horizontal: size);
}

EdgeInsets verticalPadding(double size) {
  return EdgeInsets.symmetric(vertical: size);
}

properCase(String txt) {
  return txt.titleCase;
}

capCase(String txt) {
  return txt.toUpperCase();
}

sentenceCase(String txt) {
  if (txt.isEmpty) return txt;
  return txt.sentenceCase;
}

Map replaceNulls(Map m) {
  for (var i in m.keys) {
    if (m[i] is String) {
      if (m[i] == "null") {
        m[i] = '';
      }
    } else if (m[i] == Null) {
      m[i] = '';
    } else {
      m[i] = jsonEncode(m[i]);
    }
  }
  return m;
}

bool appIsEmpty(value) {
  return value.toString() == '' || value == null || value == 'null';
}

String dateFormat(DateTime date) {
    return DateFormat("HH:mm").format(date.toUtc());
}

String formatFullDate(String? dateText) {
  dateText = dateText == "null" ? "" : dateText;
  try {
    final date = DateTime.parse(dateText.toString());
    return DateFormat("dd/MM/yyyy").format(date);
  } catch (ex) {
    return dateText.toString();
  }
}








