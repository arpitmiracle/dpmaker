
import 'package:custom_elements/custom_elements.dart';
import 'package:flutter/material.dart';

enum CustomGridViewAlignment {
  center,
  start,
  end,
  spaceBetween,
  spaceAround,
  spaceEvenly
}

class CustomGridView extends StatefulWidget {
  /// no of grid in a row
  final int rows;

  /// list of widget known as children
  final List<Widget> children;

  /// space in a between 2 grid in row
  final double rowSpace;

  /// space in a between 2 grid in column
  final double colSpace;

  /// elevation is a shadow of grid
  final double elevation;

  ///alignment of grid by default is center
  ///you can choose from CustomGridViewAlignment enum
  final CustomGridViewAlignment alignment;

  const CustomGridView({
    Key? key,
    required this.rows,
    required this.children,
    this.rowSpace = 0,
    this.colSpace = 0,
    this.elevation = 0,
    this.alignment = CustomGridViewAlignment.center,
  }) : super(key: key);

  @override
  _CustomGridViewState createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  double height = 0.0;
  late WrapAlignment alignment;
  @override
  void initState() {
    super.initState();
    height = (100 / widget.rows) - widget.rowSpace;
    switch (widget.alignment) {
    case CustomGridViewAlignment.center:
    alignment = WrapAlignment.center;
    break;
    case CustomGridViewAlignment.start:
    alignment = WrapAlignment.start;
    break;
    case CustomGridViewAlignment.end:
    alignment = WrapAlignment.end;
    break;
    case CustomGridViewAlignment.spaceBetween:
    alignment = WrapAlignment.spaceBetween;
    break;
    case CustomGridViewAlignment.spaceAround:
    alignment = WrapAlignment.spaceAround;
    break;
    case CustomGridViewAlignment.spaceEvenly:
    alignment = WrapAlignment.spaceEvenly;
    break;
  }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.rows <= 1) {
      var error = 'rows must be greater then 1';
      print('\x1B[31m======================= Error ======================');
      print('$error\x1B[0m');
      return ErrorWidget(error);
    }
    if (widget.rows > widget.children.length) {
      var error = 'children must be greater then or equal to rows';
      print('\x1B[31m======================= Error ======================');
      print('$error\x1B[0m');
      return ErrorWidget(error);
    }
    return ListView(
      children: [
        Wrap(
          alignment: alignment,
          spacing: widget.rowSpace.w,
          runSpacing: widget.colSpace.h,
          children: [
            for (int i = 0; i < widget.children.length; i++) ...[
              Container(
                height: height.w,
                width: height.w,
                child: Card(
                  elevation: widget.elevation,
                  child: widget.children[i],
                ),
              ),
            ]
          ],
        ),
      ],
    );
  }
}