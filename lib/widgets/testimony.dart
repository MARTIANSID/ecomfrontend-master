// import 'package:flutter/material.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

// class Testimony1 extends StatefulWidget {
//   @override
//   _Testimony1State createState() => _Testimony1State();
// }

// class _Testimony1State extends State<Testimony1> {
//   double rating = 0;
//   @override
//   Widget build(BuildContext context) {
//     return ClipRect(
    
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Card(
//         elevation: 4,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Your opinion matters to us!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//             Container(
//               color: Colors.grey[200],
//               child: Column(children: <Widget>[
//                 Text('How was the quality'),
//                 SmoothStarRating(
                  
//                   rating: rating,
//                   isReadOnly: false,
//                   size: 50,
//                   filledIconData: Icons.star,
//                   halfFilledIconData: Icons.star_half,
//                   defaultIconData: Icons.star_border,
//                   starCount: 5,
//                   allowHalfRating: true,
//                   spacing: 2.0,
//                   onRated: (value) {
//                     setState(() {
//                       rating = value;
//                     });
//                   },
                
//                 ),
//                Container(
//   margin: EdgeInsets.all(8.0),
//   height: 120,
//   color: Colors.white,
//   // hack textfield height
  
//   child: TextField(

//     maxLines: 50,
//     decoration: InputDecoration(
//         hintText: "Comment!",
//         border: OutlineInputBorder(),
//     ),
//   ),
// ),

//               ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
