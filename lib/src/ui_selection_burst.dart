import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';

part 'burst_linepainter.dart';

const double _kButtonOffset = 28.0;
const Size _optimalSize = Size(300.0, 300.0);

/// A StatefulWidget that creates a burst effect of selectable options.
///
/// This widget displays a series of buttons (options) arranged in a circular
/// pattern around a central FloatingActionButton. The options expand outwards
/// and contract inwards in an animated fashion when the central button is
/// pressed. The `UISelectionBurst` is customizable with various parameters
/// such as size, color, and the options themselves.
class UISelectionBurst extends StatefulWidget {
  /// The overall size of the widget.
  final Size size;

  /// A list of strings representing the options available for selection.
  final List<String> prompts;

  /// Callback function that is called with the index of the selected option.
  final Function(int) onSelected;

  /// Color of the lines connecting the central point to each option.
  final Color connectingLineColor;

  /// The stroke width of the connecting lines.
  final double strokeWidth;

  /// The widget that will toggle the animation when pressed.
  final Widget? toggleWidget;

  /// Constructs a `UISelectionBurst` widget.
  ///
  /// Takes a `key`, a callback function `onSelected`, an optional `size`
  /// for the widget, a list of `prompts` for the buttons, a `connectingLineColor`
  /// for the lines connecting buttons to the center, and a `strokeWidth` for those lines.
  const UISelectionBurst({
    super.key,
    required this.onSelected,
    this.size = _optimalSize,
    this.prompts = const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
    this.connectingLineColor = Colors.black,
    this.strokeWidth = 1.5,
    this.toggleWidget,
  });

  @override
  State<UISelectionBurst> createState() => _UISelectionBurstState();
}

/// The State class for [UISelectionBurst].
///
/// Manages the animation and layout of the [UISelectionBurst] widget, including
/// the expanding and contracting animation of the options.
class _UISelectionBurstState extends State<UISelectionBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final int buttonCount = widget.prompts.length;
  late final double radius;
  late final Widget toggleWidget;

  @override
  void initState() {
    super.initState();
    // Use the smaller of the two dimensions to calculate the radius.
    final double minSide = math.min(widget.size.width, widget.size.height);
    radius = minSide / 2.0 - _kButtonOffset;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    toggleWidget = widget.toggleWidget ??
        const FloatingActionButton(onPressed: null, child: Icon(Icons.add));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final centerX = widget.size.width / 2.0;
    final centerY = widget.size.height / 2.0;

    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildAnimatedPainter(centerX, centerY),
            ...builButtonArray(),
            GestureDetector(
              onTap: toggleAnimation,
              child: toggleWidget,
            ),
          ],
        ),
      ),
    ).withBorder(Colors.green);
  }

  List<Widget> builButtonArray() => List.generate(buttonCount, (index) {
        return AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            final offset = calculateOffset(0, 0, index);
            return Transform.translate(
              offset: offset,
              child: ElevatedButton(
                onPressed: () => widget.onSelected(index),
                child: Text(widget.prompts[index]),
              ).withOpacity(animationController.value),
            );
          },
        );
      });

  Widget buildAnimatedPainter(double centerX, double centerY) =>
      AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size.width, widget.size.height),
            painter: BurstLinePainter(
              centerX: centerX,
              centerY: centerY,
              animationValue: animationController.value,
              connectingLineColor: widget.connectingLineColor,
              strokeWidth: widget.strokeWidth,
              points: List.generate(buttonCount,
                  (index) => calculateOffset(centerX, centerY, index)),
            ),
          );
        },
      );

  Offset calculateOffset(double centerX, double centerY, int index) {
    final angle = index * (360 / buttonCount) - 90.0;
    final radian = angle * (math.pi / 180);
    final x = radius * math.cos(radian) * animationController.value;
    final y = radius * math.sin(radian) * animationController.value;
    return Offset(centerX + x, centerY + y);
  }

  /// Toggles the animation between expanded and contracted states.
  void toggleAnimation() {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}
