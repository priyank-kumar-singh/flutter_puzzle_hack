import 'package:flutter/widgets.dart';

class ExplodeAnimation extends StatefulWidget {
  const ExplodeAnimation({
    Key? key,
    required this.child,
    required this.color,
    required this.triggerAnimation,
    this.rings = 5,
    this.duration = 3000,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final int duration;
  final double rings;
  final bool triggerAnimation;

  @override
  _ExplodeAnimationState createState() => _ExplodeAnimationState();
}

class _ExplodeAnimationState extends State<ExplodeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final _ExplodeAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    _animation = _ExplodeAnimation(_controller);
  }

  @override
  void didUpdateWidget(covariant ExplodeAnimation oldWidget) {
    if (widget.triggerAnimation) {
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return AnimatedBuilder(
        animation: _controller,
        builder: ((_, child) {
          return Stack(
            children: [
              child!,
              Center(
                child: CustomPaint(
                  painter: _ExplosionPainter(
                    rings: widget.rings,
                    color: widget.color,
                    holeSize: _animation.holeSize.value * constraints.maxWidth,
                  ),
                ),
              ),
            ],
          );
        }),
        child: widget.child,
      );
    });
  }
}

class _ExplodeAnimation {
  _ExplodeAnimation(this.controller)
      : holeSize = Tween<double>(begin: 0, end: maximumHoleSize).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
          ),
        );

  final AnimationController controller;
  final Animation<double> holeSize;
  static const maximumHoleSize = 20.0;
}

class _ExplosionPainter extends CustomPainter {
  _ExplosionPainter({
    required this.color,
    required this.holeSize,
    required this.rings,
  });

  final Color color;
  final double rings;
  final double holeSize;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = holeSize / 2;
    final center = Offset(size.width / 2, size.height / 2);

    Path hole1 = Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..addOval(Rect.fromCircle(center: center, radius: radius))
        ..close(),
    );
    canvas.drawPath(hole1, Paint()..color = color);

    for (int i = 1; i < rings; ++i) {
      final hole = Path.combine(
        PathOperation.difference,
        Path()
          ..addOval(Rect.fromCircle(center: center, radius: radius / i))
          ..close(),
        Path()
          ..addOval(Rect.fromCircle(center: center, radius: radius / (i+1)))
          ..close(),
      );
      canvas.drawPath(hole, Paint()..color = color.withOpacity(1 - 0.2 * i));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
