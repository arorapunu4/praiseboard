import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Responsiveness {
  static Responsiveness _instance;
  static const Size defaultSize = Size(1920, 1080);

  Size uiSize = defaultSize;

  bool allowFontScaling;

  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;
  // SafeArea vars
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double _safeArea;
  static double _safeWidth;
  static double _safeHeight;

  Responsiveness._() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _safeAreaHorizontal = mediaQuery.padding.left + mediaQuery.padding.right;
    _safeAreaVertical = mediaQuery.padding.top + mediaQuery.padding.bottom;
    _safeArea = _safeAreaHorizontal + _safeAreaVertical;
    _safeWidth =
        _screenWidth - mediaQuery.padding.left - mediaQuery.padding.right;
    _safeHeight = _screenHeight - _statusBarHeight - _bottomBarHeight;
  }

  factory Responsiveness() {
    assert(
      _instance != null,
      '\nEnsure to initialize Responsiveness before accessing it.',
    );
    return _instance;
  }

  static void init({
    Size designSize = defaultSize,
    bool allowFontScaling = false,
  }) {
    _instance ??= Responsiveness._();
    _instance
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling;
  }

  static double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  static double get screenWidth => _screenWidth;

  /// The vertical extent of this size. dp
  static double get screenHeight => _screenHeight;

  /// The vertical extent of this size. px
  static double get screenWidthPx => _screenWidth * _pixelRatio;

  /// The vertical extent of this size. px
  static double get screenHeightPx => _screenHeight * _pixelRatio;

  /// The offset from the top
  static double get statusBarHeight => _statusBarHeight;

  /// The offset from the bottom.
  static double get bottomBarHeight => _bottomBarHeight;

  /// Safe Area(Vertical +  Horizontal)
  static double get safeArea => _safeArea;

  /// Safe Area horizontal
  static double get safeAreaHorizontal => _safeAreaHorizontal;

  /// Safe Area Vertical
  static double get safeAreaVertical => _safeAreaVertical;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => scaleWidth;

  /// safeAreaScaleWidth
  double get scaleSafeAreaWidth => _safeWidth / uiSize.width;

  /// safeAreaScaleWidth
  double get scaleSafeAreaHeight => _safeHeight / uiSize.height;

  double get scaleSafeAreaText => scaleSafeAreaWidth;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  num setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  num setHeight(num height) => height * scaleHeight;

  num setSafeAreaWidth(num width) => width * scaleSafeAreaWidth;

  num setSafeAreaHeight(num height) => height * scaleSafeAreaHeight;

  num setSpacing(num spacing) => spacing * scaleWidth;

  num setHorizontalSpacing(num spacing) => spacing * scaleWidth;

  num setVerticalSpacing(num spacing) => spacing * scaleHeight;

  num setSafeAreaSpacing(num spacing) => spacing * scaleSafeAreaWidth;

  /// Horizontal Spacing function
  num setSafeAreaHorizontalSpacing(num spacing) => spacing * scaleSafeAreaWidth;

  /// Vertical Spacing function
  num setSafeAreaVerticalSpacing(num spacing) => spacing * scaleSafeAreaHeight;

  /// Icon sizing function
  num setIconSize(num size) => size * scaleWidth;

  /// Icon sizing function
  num setSafeAreaIconSize(num size) => size * scaleSafeAreaWidth;

  ///@param [fontSize]
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the UI design, in px.
  ///@param [allowFontScaling]
  num setFontSize(num fontSize, {bool allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor))
          : (allowFontScalingSelf
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor));

  ///@param [fontSize]
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the SafeArea UI design, in px.
  ///@param [allowFontScaling]
  num setSafeAreaFontSize(num fontSize, {bool allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleSafeAreaText)
              : ((fontSize * scaleSafeAreaText) / _textScaleFactor))
          : (allowFontScalingSelf
              ? (fontSize * scaleSafeAreaText)
              : ((fontSize * scaleSafeAreaText) / _textScaleFactor));
}

extension ResponsivenessExtension on num {
  // shorthand for width
  num get w => Responsiveness().setWidth(this);

  // shorthand for height
  num get h => Responsiveness().setHeight(this);

  // shorthand for fontsize
  num get f => Responsiveness().setFontSize(this);

  // shorthand for spacing(Padding, margin)
  num get s => Responsiveness().setSpacing(this);

  // shorthand for spacing(Vertical Padding, Vertical margin)
  num get vs => Responsiveness().setVerticalSpacing(this);

  // shorthand for spacing(Horizontal Padding, Horizontal margin)
  num get hs => Responsiveness().setHorizontalSpacing(this);

  // shorthand for icon size
  num get ics => Responsiveness().setIconSize(this);

  // shorthand for safe width
  num get sw => Responsiveness().setSafeAreaWidth(this);

  // shorthand for safe height
  num get sh => Responsiveness().setSafeAreaHeight(this);

  // shorthand for safe fontsize
  num get sf => Responsiveness().setSafeAreaFontSize(this);

  // shorthand for spacing(Padding, margin)
  num get ss => Responsiveness().setSafeAreaSpacing(this);

  // shorthand for spacing(Vertical Padding, Vertical margin)
  num get svs => Responsiveness().setSafeAreaVerticalSpacing(this);

  // shorthand for spacing(Vertical Padding, Vertical margin)
  num get shs => Responsiveness().setHorizontalSpacing(this);

  // shorthand for icon size
  num get sics => Responsiveness().setSafeAreaIconSize(this);

  // shorthand for circle diameter size
  num get d => Responsiveness().setWidth(this);
}
