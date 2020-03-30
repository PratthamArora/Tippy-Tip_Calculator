import 'package:flutter/material.dart';
import 'package:tippy/tippy.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Tippy(),
        theme: ThemeData.light(),
      ),
    );
