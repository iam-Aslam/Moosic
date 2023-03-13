// import 'package:flutter/material.dart';
// import 'package:moosic/presentations/widgets/data.dart';
// import '../../../widgets/common.dart';

// class Downloads extends StatefulWidget {
//   const Downloads({super.key});

//   @override
//   State<Downloads> createState() => _DownloadsState();
// }

// var orientation, size, height, width;

// class _DownloadsState extends State<Downloads> {
//   @override
//   Widget build(BuildContext context) {
//     orientation = MediaQuery.of(context).orientation;
//     //size of the window
//     size = MediaQuery.of(context).size;
//     height = size.height;
//     width = size.width;
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(children: [
//           Column(
//             children: [
//               Container(
//                 width: width / 1,
//                 height: height / 2.8,
//                 child: FittedBox(
//                   fit: BoxFit.fill,
//                   child: Image.asset(
//                     'assets/images/downloads.jpg',
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.5),
//                   child: Column(
//                     children: [
//                       titleslib(title: 'Downloaded Songs'),
//                       Expanded(
//                         child: GridView.count(
//                           shrinkWrap: true,
//                           // physics: const NeverScrollableScrollPhysics(),
//                           crossAxisCount: 2,
//                           children: List.generate(
//                             favorsong.length,
//                             (index) => favoritedummy(
//                                 song: favorsong[index],
//                                 image: favorimg[index],
//                                 time: favortime[index]),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20.0, top: 15),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: const CircleAvatar(
//                   backgroundColor: Colors.white,
//                   backgroundImage: AssetImage('assets/images/arrowback.png'),
//                 ),
//               ),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
