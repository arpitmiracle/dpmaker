import 'package:flutter/material.dart';

List<Layer> layers = [], removedLayers = [];

/// Text layer
class TextLayer extends StatefulWidget {
  final TextLayerData layerData;
  final VoidCallback? onUpdate;
  final VoidCallback? onLongPress;

  const TextLayer({
    Key? key,
    required this.layerData,
    this.onUpdate,
    this.onLongPress,
  }) : super(key: key);
  @override
  _TextViewState createState() => _TextViewState();
}

class _TextViewState extends State<TextLayer> {
  double initialSize = 0;
  double initialRotation = 0;

  @override
  Widget build(BuildContext context) {
    initialSize = widget.layerData.size;
    initialRotation = widget.layerData.rotation;

    return Positioned(
      left: widget.layerData.offset.dx,
      top: widget.layerData.offset.dy,
      child: GestureDetector(
        onTap: () {
          // showModalBottomSheet(
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(10),
          //       topLeft: Radius.circular(10),
          //     ),
          //   ),
          //   barrierColor: Colors.black.withOpacity(0.15),
          //   context: context,
          //   builder: (context) {
          //     return TextLayerOverlay(
          //       index: layers.indexOf(widget.layerData),
          //       layer: widget.layerData,
          //       onUpdate: () {
          //         if (widget.onUpdate != null) widget.onUpdate!();
          //         setState(() {});
          //       },
          //     );
          //   },
          // );
        },
        onScaleUpdate: (detail) {
          if (detail.pointerCount == 1) {
            widget.layerData.offset = Offset(
              widget.layerData.offset.dx + detail.focalPointDelta.dx,
              widget.layerData.offset.dy + detail.focalPointDelta.dy,
            );
          } else if (detail.pointerCount == 2) {
            widget.layerData.size =
                initialSize + detail.scale * (detail.scale > 1 ? 1 : -1);

            // print('angle');
            // print(detail.rotation);
            widget.layerData.rotation = detail.rotation;
          }
          setState(() {});
        },
        onLongPress: () {
          TextEditingController textFieldController = TextEditingController(text: widget.layerData.text.toString());
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Insert Your Message'),
                contentPadding: EdgeInsets.only(bottom: 24,left: 24,right: 24),
                content: Container(
                  width: double.infinity,
                  child: TextField(
                    controller: textFieldController,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(hintText: "Type something"),
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      widget.layerData.text = textFieldController.text;
                      if (widget.onUpdate != null) widget.onUpdate!();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Transform.rotate(
          angle: widget.layerData.rotation,
          child: Container(
            padding: const EdgeInsets.all(64),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.layerData.background
                    .withAlpha(widget.layerData.backgroundOpacity.toInt()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.layerData.text.toString(),
                textAlign: widget.layerData.align,
                style: TextStyle(
                  color: widget.layerData.color,
                  fontSize: widget.layerData.size,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// class TextLayerOverlay extends StatefulWidget {
//   final int index;
//   final TextLayerData layer;
//   final Function onUpdate;
//
//   const TextLayerOverlay({
//     Key? key,
//     required this.layer,
//     required this.index,
//     required this.onUpdate,
//   }) : super(key: key);
//
//   @override
//   _TextLayerOverlayState createState() => _TextLayerOverlayState();
// }
//
// class _TextLayerOverlayState extends State<TextLayerOverlay> {
//   double slider = 0.0;
//
//   @override
//   void initState() {
//     //  slider = widget.sizevalue;
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       decoration: const BoxDecoration(
//         color: Colors.black87,
//         borderRadius: BorderRadius.only(
//             topRight: Radius.circular(10), topLeft: Radius.circular(10)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Center(
//               child: Text(
//                 i18n('Size Adjust').toUpperCase(),
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             const Divider(),
//             Slider(
//                 activeColor: Colors.white,
//                 inactiveColor: Colors.grey,
//                 value: widget.layer.size,
//                 min: 0.0,
//                 max: 100.0,
//                 onChangeEnd: (v) {
//                   setState(() {
//                     widget.layer.size = v.toDouble();
//                     widget.onUpdate();
//                   });
//                 },
//                 onChanged: (v) {
//                   setState(() {
//                     slider = v;
//                     // print(v.toDouble());
//                     widget.layer.size = v.toDouble();
//                     widget.onUpdate();
//                   });
//                 }),
//             const SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 const SizedBox(height: 20),
//                 Text('Color', style: const TextStyle(color: Colors.white)),
//                 Row(children: [
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: BarColorPicker(
//                       width: MediaQuery.of(context).size.width * 0.72,
//                       thumbColor: Colors.white,
//                       initialColor: widget.layer.color,
//                       cornerRadius: 10,
//                       pickMode: PickMode.color,
//                       colorListener: (int value) {
//                         setState(() {
//                           widget.layer.color = Color(value);
//                           widget.onUpdate();
//                         });
//                       },
//                     ),
//                   ),
//                   TextButton(
//                     child: Text(
//                         'Custom',
//                         style: const TextStyle(color: Colors.white)
//                     ),
//                     onPressed: () async {
//                       var color = await showPickerDialog(context,color: widget.layer.color);
//                       if(color != null){
//                         setState(() {
//                           widget.layer.color = color;
//                           widget.onUpdate();
//                         });
//                       }
//                     },
//                   ),
//                   const SizedBox(width: 16),
//                 ]),
//                 const SizedBox(height: 20),
//                 Text('Background Color',
//                     style: const TextStyle(color: Colors.white)),
//                 Row(children: [
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: BarColorPicker(
//                       width: MediaQuery.of(context).size.width * 0.72,
//                       initialColor: widget.layer.background,
//                       thumbColor: Colors.white,
//                       cornerRadius: 10,
//                       pickMode: PickMode.color,
//                       colorListener: (int value) {
//                         setState(() {
//                           widget.layer.background = Color(value);
//                           widget.onUpdate();
//                         });
//                       },
//                     ),
//                   ),
//                   TextButton(
//                     child: Text(
//                         'Custom',
//                         style: const TextStyle(color: Colors.white)
//                     ),
//                     onPressed: () async {
//                       var color = await showPickerDialog(context,color: widget.layer.background);
//                       if(color != null){
//                         setState(() {
//                           widget.layer.background = color;
//                           widget.onUpdate();
//                         });
//                       }
//                     },
//                   ),
//                   const SizedBox(width: 16),
//                 ]),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Background Opacity',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 Row(children: [
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Slider(
//                       min: 0,
//                       max: 255,
//                       divisions: 255,
//                       value: widget.layer.backgroundOpacity.toDouble(),
//                       thumbColor: Colors.white,
//                       onChanged: (double value) {
//                         setState(() {
//                           widget.layer.backgroundOpacity = value.toInt();
//                           widget.onUpdate();
//                         });
//                       },
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         widget.layer.backgroundOpacity = 0;
//                         widget.onUpdate();
//                       });
//                     },
//                     child: Text(
//                       'Reset',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                 ]),
//               ]),
//             ),
//             const SizedBox(height: 10),
//             Row(children: [
//               Expanded(
//                 child: TextButton(
//                   onPressed: () {
//                     removedLayers.add(layers.removeAt(widget.index));
//
//                     Navigator.pop(context);
//                     widget.onUpdate();
//                     // back(context);
//                     // setState(() {});
//                   },
//                   child: Text(
//                     'Remove',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }


/// Layer class with some common properties
class Layer {
  late Offset offset;
  late double rotation, scale, opacity;

  Layer({
    Offset? offset,
    double? opacity,
    double? rotation,
    double? scale,
  }) {
    this.offset = offset ?? const Offset(64, 64);
    this.opacity = opacity ?? 1;
    this.rotation = rotation ?? 0;
    this.scale = scale ?? 1;
  }
}

/// Attributes used by [TextLayer]
class TextLayerData extends Layer {
  String text;
  double size;
  Color color, background;
  int backgroundOpacity;
  TextAlign align;

  TextLayerData({
    required this.text,
    this.size = 35,
    this.color = Colors.white,
    this.background = Colors.transparent,
    this.backgroundOpacity = 1,
    this.align = TextAlign.left,
    Offset? offset,
    double? opacity,
    double? rotation,
    double? scale,
  }) : super(
    offset: offset,
    opacity: opacity,
    rotation: rotation,
    scale: scale,
  );
}
