import 'package:flutter/widgets.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.text, {
    Key? key,
    this.ltr = true,
    this.fillColor = const Color.fromARGB(255, 245, 237, 170),
    this.textStyle,
    this.fontSize,
    this.margin,
    this.padding,
  }) : assert(fontSize == null || textStyle == null),
    super(key: key);

  /// Text to be displayed inside the message box
  final String text;

  /// Determines whether the cone at the bottom of the message box is at left side or right side
  ///
  /// By default [ltr] is true means cone is at bottom left side of the message box
  final bool ltr;

  /// Background color of message box
  final Color fillColor;

  /// Text style of the message inside the message box.
  ///
  /// [textStyle] should be null if [fontSize] is provided
  final TextStyle? textStyle;

  /// Font size of the message inside the message box
  ///
  /// [fontSize] should be null if [textStyle] is provided
  final double? fontSize;

  /// Padding for the content inside message box
  final EdgeInsetsGeometry? padding;

  /// Margin of the message box
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(fillColor, ltr),
      child: Container(
        child: Text(
          text,
          style: textStyle ?? TextStyle(
            fontSize: fontSize,
          ),
        ),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        margin: margin,
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final Color color;
  final bool ltr;

  _BubblePainter(this.color, this.ltr);

  static const dx = 14.0;
  static const dy = dx / 1.2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final height = size.height;
    final width = ltr ? 0 : size.width;
    final sign = ltr ? -1 : 1;

    final path = Path()
      ..moveTo(width + sign * dx, height + dy)
      ..quadraticBezierTo(width + sign * dx/4, (height + dx/2), width - sign * 1, height - dx,)
      ..lineTo(width - dx/2, height)
      ..quadraticBezierTo(width + sign * dx/4, (height + dx/1.8), width + sign * dx, height + dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
