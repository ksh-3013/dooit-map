// import 'package:flutter/material.dart';
//
// Widget _stopwatchSection() => SizedBox(
//   width: 350,
//   height: 350,
//   child: Stack(
//     alignment: Alignment.center,
//     children: [
//       Image.asset('assets/images/timer_bg.png', color: Colors.green),
//       Consumer<StopwatchProvider>(
//         builder: (_, sp, __) => Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               sp.formatted,
//               style: const TextStyle(
//                 fontSize: 46,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'HSSanTokki',
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: const StadiumBorder(),
//                     backgroundColor: Colors.black,
//                   ),
//                   onPressed: sp.toggle,
//                   child: Text(sp.isRunning ? '일시정지' : '시작'),
//                 ),
//                 const SizedBox(width: 15),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: const StadiumBorder(),
//                     backgroundColor: Colors.grey.shade600,
//                   ),
//                   onPressed: sp.reset,
//                   child: const Text('리셋'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// );
