// import 'package:flutter/material.dart';

// class FilterPage extends StatefulWidget {
//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   RangeValues _priceRange = RangeValues(10, 80);
//   double _rating = 5;
//   String _category = 'Crop Tops';
//   List<bool> _discounts = [false, false, false, false];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Filter Example'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_alt_outlined),
//             onPressed: () {
//               Scaffold.of(context).openEndDrawer();
//             },
//           ),
//         ],
//       ),
//       endDrawer: Drawer(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Price'),
//                 RangeSlider(
//                   values: _priceRange,
//                   min: 10,
//                   max: 80,
//                   divisions: 7,
//                   labels: RangeLabels(
//                     '\$${_priceRange.start.round()}',
//                     '\$${_priceRange.end.round()}',
//                   ),
//                   onChanged: (RangeValues values) {
//                     setState(() {
//                       _priceRange = values;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 16),

//                 // Color Options
//                 Text('Color'),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     CircleAvatar(backgroundColor: Colors.orange),
//                     SizedBox(width: 8),
//                     CircleAvatar(backgroundColor: Colors.red),
//                     SizedBox(width: 8),
//                     CircleAvatar(backgroundColor: Colors.blue),
//                     SizedBox(width: 8),
//                     CircleAvatar(backgroundColor: Colors.black),
//                     SizedBox(width: 8),
//                     CircleAvatar(backgroundColor: Colors.white),
//                     SizedBox(width: 8),
//                     CircleAvatar(backgroundColor: Colors.pink),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Star Rating
//                 Text('Star Rating'),
//                 Row(
//                   children: List.generate(5, (index) {
//                     return IconButton(
//                       icon: Icon(
//                         Icons.star,
//                         color: index < _rating ? Colors.amber : Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _rating = index + 1.0;
//                         });
//                       },
//                     );
//                   }),
//                 ),
//                 SizedBox(height: 16),

//                 // Category Dropdown
//                 Text('Category'),
//                 DropdownButton<String>(
//                   value: _category,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _category = newValue!;
//                     });
//                   },
//                   items: <String>['Crop Tops', 'T-Shirts', 'Jeans', 'Jackets']
//                       .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       })
//                       .toList(),
//                 ),
//                 SizedBox(height: 16),

//                 // Discount Options
//                 Text('Discount'),
//                 Wrap(
//                   spacing: 8,
//                   children: List.generate(4, (index) {
//                     List<String> discounts = [
//                       '50% off',
//                       '40% off',
//                       '30% off',
//                       '25% off',
//                     ];
//                     return ChoiceChip(
//                       label: Text(discounts[index]),
//                       selected: _discounts[index],
//                       onSelected: (bool selected) {
//                         setState(() {
//                           _discounts[index] = selected;
//                         });
//                       },
//                     );
//                   }),
//                 ),
//                 Spacer(),

//                 // Apply Button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           // Reset values
//                           _priceRange = RangeValues(10, 80);
//                           _rating = 5;
//                           _category = 'Crop Tops';
//                           _discounts = [false, false, false, false];
//                         });
//                       },
//                       child: Text('Reset'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Apply filter logic here
//                         Navigator.pop(context); // drawer band karna
//                       },
//                       child: Text('Apply'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
