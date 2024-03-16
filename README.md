# UI Selection Burst

A Flutter package for displaying a burst of selectable options around a central point, animated with a beautiful expanding and contracting effect.

## Features

- Customizable number of options.
- Animated expansion and contraction of options.
- Customizable colors, sizes, and strokes.
- Easy to integrate with any Flutter application.

## Getting Started

To use the UI Selection Burst widget, follow these simple steps:

**Add the package to your Flutter project**: First, you need to include `ui_extensions_flutter` in your project's dependencies. Since `UISelectionBurst` is a custom widget, ensure you have the necessary parts of this code in your project.

pubspec.yaml

```yaml
dependencies:
  ui_selection_burst_flutter:
    git: https://github.com/GitHubStuff/ui_selection_burst_flutter.git
```

**Import the package**: Import the necessary Dart files into your Flutter application where you plan to use the UI Selection Burst widget.

```dart
import 'package:your_project/ui_selection_burst.dart';

UISelectionBurst(
  size: Size(300.0, 300.0),
  prompts: ['1', '2', '3', '4'],
  onSelected: (int index) {
    print("Selected option index: $index");
  },
  connectingLineColor: Colors.blue,
  strokeWidth: 2.0,
  toggleWidget: FloatingActionButton(onPressed: null, child: Icon(Icons.add)),
)
```

**Customization:**

Customize the following properties of the **UISelectionBurst** widget:

*size*: The size of the widget.

*prompts*: A list of strings that will be displayed on each selectable option.

*onSelected*: A callback function that returns the index of the selected option.

*connectingLineColor*: The color of the lines connecting the central point to each option.

*strokeWidth*: The width of the connecting lines.

*toggleWidget*: The center widget that tapped/expands collapes the widget.

## License

2004 Apache 2.0 - See the *LICENSE.txt* file.

## Finally

Be kind to each other.
