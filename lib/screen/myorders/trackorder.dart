import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Track Order',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivered on 15.05.21',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                'Tracking Number : IK287368638',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              _buildTrackingTimeline(),
              const SizedBox(height: 30),
              _buildRatingCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    final List<Map<String, String>> trackingEvents = [
      {
        'status': 'Parcel is successfully delivered',
        'time': '15 May 10:20',
        'isCompleted': 'false'
      },
      {'status': 'Parcel is out for delivery', 'time': '14 May 08:00', 'isCompleted': 'true'},
      {
        'status': 'Parcel is received at delivery Branch',
        'time': '13 May 17:25',
        'isCompleted': 'true'
      },
      {'status': 'Parcel is in transit', 'time': '13 May 07:00', 'isCompleted': 'true'},
      {'status': 'Sender has shipped your parcel', 'time': '12 May 14:25', 'isCompleted': 'true'},
      {
        'status': 'Sender is preparing to ship your order',
        'time': '12 May 10:01',
        'isCompleted': 'true'
      },
    ];

    return Column(
      children: trackingEvents.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, String> event = entry.value;
        bool isLast = index == trackingEvents.length - 1;
        bool isCompleted = event['isCompleted'] == 'true'; // All are completed in the image

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  _buildTimelineDot(isCompleted),
                  if (!isLast)
                    const Column(
                      children: [
                        Text('•', style: TextStyle(color: Colors.black, fontSize: 30)),
                        Text('•', style: TextStyle(color: Colors.black, fontSize:30)),
                        Text('•', style: TextStyle(color: Colors.black, fontSize: 30)),
                      ],
                    ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['status']!,
                      style: TextStyle(
                        color: isCompleted ? Colors.black : Colors.grey[600],
                        fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      event['time']!,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

Widget _buildTimelineDot(bool isCompleted) {
    return Container(
      width: 22, // Slightly larger to match the image
      height: 22, // Slightly larger to match the image
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black, // Grey border for all
          width: 3,
        ),
      ),
      child: isCompleted
          ? Icon(
              Icons.check,
              color: Colors.black, // Black checkmark
              size: 14, // Smaller checkmark to fit
            )
          : null, // No icon if not completed, though all are completed in the image
    );
  }

  Widget _buildRatingCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingThumbIcon(),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Don't forget to rate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Rate product to get 5 points for collect.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < 3 ? Colors.yellow[700] : Colors.grey[300],
                      size: 24,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingThumbIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow[700]!.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.white, size: 10),
                Text(
                  '3',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        const Icon(Icons.thumb_up_alt_outlined, color: Colors.black, size: 24),
      ],
    );
  }
}
