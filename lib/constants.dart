import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
//CHANGE THIS URL TO HOST IN SERVER
const urlServ = "http://localhost:8000";
const PdfColor green = PdfColor.fromInt(0xffe06c6c); //darker background color
const PdfColor lightGreen =
    PdfColor.fromInt(0xffedabab); //light background color

const _darkColor = PdfColor.fromInt(0xff242424);
const _lightColor = PdfColor.fromInt(0xff9D9D9D);
const PdfColor baseColor = PdfColor.fromInt(0xffD32D2D);
const PdfColor _baseTextColor = PdfColor.fromInt(0xffffffff);
const PdfColor accentColor = PdfColor.fromInt(0xfff1c0c0);
