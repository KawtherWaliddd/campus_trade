// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// class Dropdown extends StatefulWidget {
//   const Dropdown({super.key});

//   @override
//   State<Dropdown> createState() => _DropdownState();
// }

// class _DropdownState extends State<Dropdown> {
//   final List<String> roles = [
//     'Engineering',
//     'Medicine',
//     'Veterinary',
//     'Others'
//   ];
//   String selectedRole = 'Engineering';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         DropdownButtonFormField<String>(
//           value: selectedRole,
//           dropdownColor: Colors.white,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 18, // تكبير الخط
//             fontWeight: FontWeight.w500,
//           ),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 12, vertical: 14), // ضبط التباعد الداخلي
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(
//                 color: Color(0xff378BCB),
//                 width: 1.5,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(
//                 color: Colors.grey,
//                 width: 1.2,
//               ),
//             ),
//           ),
//           items: roles.map((String role) {
//             return DropdownMenuItem<String>(
//               value: role,
//               child: Text(
//                 role,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             if (newValue != null) {
//               setState(() {
//                 selectedRole = newValue;
//               });
//             }
//           },
//           icon: const Icon(
//             Icons.arrow_drop_down,
//             color: Colors.grey,
//             size: 30, // تقليل حجم الأيقونة
//           ),
//         ),
//       ],
//     );
//   }
// }
