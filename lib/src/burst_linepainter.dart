part of 'ui_selection_burst.dart';

/// CustomPainter for drawing connecting lines in the UISelectionBurst widget.
///
/// This painter draws lines from a central point to various points around it,
/// creating a burst effect. The visibility and style of the lines are animated
/// based on the animation value provided.
class BurstLinePainter extends CustomPainter {
  /// The X coordinate of the center point from which lines will radiate.
  final double centerX;

  /// The Y coordinate of the center point from which lines will radiate.
  final double centerY;

  /// The current animation value, affecting the opacity of the lines.
  /// Values range from 0.0 to 1.0.
  final double animationValue;

  /// The points around the center to which the lines will be drawn.
  final List<Offset> points;

  /// The color of the connecting lines.
  final Color connectingLineColor;

  /// The stroke width of the connecting lines.
  final double strokeWidth;

  /// Constructs a [BurstLinePainter] with specified properties for drawing.
  ///
  /// Requires center coordinates, a list of points for line endpoints,
  /// an animation value for dynamic styling, a color, and a stroke width
  /// for the lines.
  BurstLinePainter({
    required this.centerX,
    required this.centerY,
    required this.points,
    required this.animationValue,
    required this.connectingLineColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = connectingLineColor.withOpacity(animationValue)
      ..strokeWidth = strokeWidth;

    for (var point in points) {
      canvas.drawLine(Offset(centerX, centerY), point, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BurstLinePainter oldDelegate) => true;
}
