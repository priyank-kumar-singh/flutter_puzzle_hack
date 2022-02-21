import 'package:flutter/widgets.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    this.text,
    this.child,
    this.fillColor = const Color.fromARGB(255, 245, 237, 170),
    this.textStyle,
    this.fontSize,
    this.margin,
    this.padding,
  }) : assert(fontSize == null || textStyle == null),
    assert(text != null || child != null),
    assert(text == null || child == null),
    super(key: key);

  /// Text to be displayed inside the message box
  final String? text;

  /// Child widget to be displyed in the message box
  final Widget? child;

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
      painter: _BubblePainter(fillColor),
      child: Container(
        child: child ?? Text(
          text!,
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

  _BubblePainter(this.color);

  static const dx = 10.0;
  static const dy = dx / 0.6;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final height = size.height - 2.0;
    final widthHalf = size.width / 2;

    final path = Path()
      ..moveTo(widthHalf - dx, height)
      ..lineTo(widthHalf - dx/5, height + dy - 4.0)
      ..quadraticBezierTo(widthHalf, height + dy, widthHalf + dx/5, height + dy - 4.0)
      ..lineTo(widthHalf + dx, height)
      ..lineTo(widthHalf - dx, height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
