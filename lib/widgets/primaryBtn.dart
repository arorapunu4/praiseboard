import 'package:flutter/material.dart';

import 'package:praiseboard/colors.dart';
import 'package:praiseboard/responsiveness.dart';
//import 'package:gaia/widgets/common/progressbars/loading_circularbar.dart';

/// Use [PrimaryButton] where in the places of common Raised Button.
/// Needs text, onPressed Function, disabled flag.
/// Have Solid background with white or other color as text color.
/// Use [PrimaryButton] like this:
///
/// To check disabled state of the [PrimaryButton]
/// pass [onPressed = null] if disabled is true
/// and use [disabled = onPressed == null] condition check
///
/// For child <Widget>
///   ```dart
///  PrimaryButton({
///    child: Text('login'),
///    onPressed: () => login(),
///    disabled: false,
///  });
///  ```
///
/// For Button with text
///  ```dart
///  PrimaryButton({
///    text: 'login',
///    onPressed: () => login(),
///    disabled: false,
///  });
///  ```
///
class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final String text;
  final bool color;
  final Color linearLeft;
  final Color linearRight;
  final bool isLoading;
  final bool isButtonLoader;
  final TextStyle style;

  const PrimaryButton({
    @required this.onPressed,
    this.child,
    this.color = false,
    this.text = '',
    this.linearLeft,
    this.linearRight,
    this.isLoading = false,
    this.isButtonLoader = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    bool disabled = onPressed == null;
    final ButtonStyle textButtonStyle = ButtonStyle(
      overlayColor: MaterialStateProperty.all(
        Colors.white,
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white;
          }
          return style?.color ?? Colors.white;
        },
      ),
      textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.button),
    );

    /// [buttonGradientColors] returns the gradient color accordingly

    return Container(
      height: 82.h,
      width: 200.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.s),
        color: AppColors.primaryColor
      ),
      child: SizedBox.expand(
        child: TextButton(
          style: textButtonStyle,
          onPressed: onPressed,
          child: isLoading ? CircularProgressIndicator() : Text(text),
        ),
      ),
    );
  }
}
