import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:appepunemiscan/src/utils/colors.dart';
import 'package:appepunemiscan/src/utils/font_family.dart';

mediumText(text, color, double size, [TextAlign? align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_MEDIUM,
          fontSize: size,
          color: color),
    );

boldText(text, color, double size, [TextAlign? align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_BOLD, fontSize: size, color: color),
    );

blackText(text, color, double size, [TextAlign? align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_BLACK,
          fontSize: size,
          color: color),
    );

lightText(text, color, double size, [TextAlign? align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_LIGHT,
          fontSize: size,
          color: color),
    );

regularText(text, color, double size, [TextAlign? align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_REGULAR,
          fontSize: size,
          color: color),
    );

containerButton(onTap, text) => InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorResources.orangeFB9,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: boldText(text, ColorResources.white, 16),
        ),
      ),
    );

textField(hintText, icon) => TextFormField(
      cursorColor: ColorResources.black,
      style: TextStyle(
        color: ColorResources.black,
        fontSize: 16,
        fontFamily: TextFontFamily.ROBOTO_REGULAR,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(15),
          child: SvgPicture.asset(icon),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorResources.grey9CA,
          fontSize: 16,
          fontFamily: TextFontFamily.ROBOTO_REGULAR,
        ),
        filled: true,
        fillColor: ColorResources.greyF9F,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

textField1(hintText) => TextFormField(
      cursorColor: ColorResources.black,
      style: TextStyle(
        color: ColorResources.black,
        fontSize: 16,
        fontFamily: TextFontFamily.ROBOTO_REGULAR,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorResources.grey9CA,
          fontSize: 16,
          fontFamily: TextFontFamily.ROBOTO_REGULAR,
        ),
        filled: true,
        fillColor: ColorResources.greyF9F,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

commonColumn(image, text, onTap) => Column(
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorResources.blue1D3,
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: InkWell(
              onTap: onTap,
              child: SvgPicture.asset(image),
            ),
          ),
        ),
        SizedBox(height: 5),
        regularText(text, ColorResources.grey6B7, 13, TextAlign.center),
      ],
    );
