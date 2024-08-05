// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class HistoryWidget extends StatefulWidget {
//   final IconData iconLeft;
//   final String text;
//   final VoidCallback onTap;
//   final bool isLast;

//   const HistoryWidget({
//     required this.iconLeft,
//     required this.text,
//     required this.onTap,
//     this.isLast = false,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<HistoryWidget> createState() => _HistoryWidgetState();
// }

// class _HistoryWidgetState extends State<HistoryWidget> {
//   String getCurrentTime() {
//     return DateFormat('HH:mm').format(DateTime.now());
//   }

//   String getCurrentDate() {
//     return DateFormat('dd/MM/yyyy').format(DateTime.now());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ListTile(
//               contentPadding: const EdgeInsets.all(5),
//               leading: Icon(
//                 widget.iconLeft,
//                 size: 25,
//                 color: Colors.blueGrey,
//               ),
//               title: Text(
//                 widget.text,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   color: Colors.black,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//               subtitle: Text(
//                 '${getCurrentTime()} - ${getCurrentDate()}',
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//               onTap: widget.onTap,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryWidget extends StatefulWidget {
  final IconData iconLeft;
  final String text;
  final VoidCallback onTap;
  final bool isLast;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final Color subtitleColor;

  const HistoryWidget({
    required this.iconLeft,
    required this.text,
    required this.onTap,
    this.isLast = false,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.blueGrey,
    this.textColor = Colors.black,
    this.subtitleColor = Colors.grey,
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  String getCurrentTime() {
    return DateFormat('HH:mm').format(DateTime.now());
  }

  String getCurrentDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: const Icon(
                Icons.history,
                size: 25,
                color: Colors.blueAccent,
              ),
              title: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 15,
                  color: widget.textColor,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: Text(
                '${getCurrentTime()} - ${getCurrentDate()}',
                style: TextStyle(
                  fontSize: 12,
                  color: widget.subtitleColor,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: const Icon(
                Icons.directions,
                size: 25,
                color: Colors.blueGrey,
              ),
              onTap: widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final List<String> _searchResults = [
    'Location 1',
    'Location 2',
    'Location 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            String result = _searchResults[index];
            return HistoryWidget(
              iconLeft: Icons.location_on,
              text: result,
              onTap: () {
                // Handle tap on search result
                log('Selected location: $result');
              },
              backgroundColor: Colors.white,
              iconColor: Colors.blueGrey,
              textColor: Colors.black,
              subtitleColor: Colors.grey,
            );
          },
        ),
      ),
    );
  }
}
