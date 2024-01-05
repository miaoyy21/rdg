// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Number Circle',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: NumberCircleScreen(),
//     );
//   }
// }
//
// class NumberCircleScreen extends StatelessWidget {
//   final List<int> numbers = List.generate(28, (index) => index + 1);
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Number Circle'),
//       ),
//       body: Center(
//         child: Container(
//           width: width,
//           height: width,
//           child: Stack(
//             children: _buildNumberCircles(width),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildNumberCircles(double width) {
//     final List<Widget> circles = [];
//
//     final double radius = (width - 48) / 2;
//     final double centerX = width / 2;
//     final double centerY = width / 2;
//     final double angle = 2 * math.pi / numbers.length;
//
//     for (int i = 0; i < numbers.length; i++) {
//       final double x = centerX + radius * math.cos(i * angle);
//       final double y = centerY + radius * math.sin(i * angle);
//
//       circles.add(
//         Positioned(
//           left: x - 18.0,
//           top: y - 18.0,
//           child: InkWell(
//             onTap: () {
//               _onNumberTap(numbers[i]);
//             },
//             overlayColor: MaterialStateProperty.all(Colors.transparent),
//             child: Container(
//               width: 36.0,
//               height: 36.0,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.blue, width: 2.0),
//               ),
//               child: Center(
//                 child: Text(
//                   '${numbers[i]}',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//     return circles;
//   }
//
//   void _onNumberTap(int number) {
//     print('Clicked number: $number');
//   }
// }
