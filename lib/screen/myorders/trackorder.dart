import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrderScreen extends StatelessWidget {
  TrackOrderScreen({super.key});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                           decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                size: 20, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        'Track Order',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Delivered on 15.05.21',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height:10),
              const Text(
                'Tracking Number : IK287368638',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
               SizedBox(height: 30),
     Column(
      children: trackingEvents.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, String> event = entry.value;
        bool isLast = index == trackingEvents.length - 1;
        bool isCompleted = event['isCompleted'] == 'true';

        return TimelineTile(
          isFirst: index == 0,
          isLast: isLast,
          alignment: TimelineAlign.start,
          indicatorStyle: IndicatorStyle(
            width: 30,
            height: 30,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                color: isCompleted ? Colors.black : Colors.transparent,
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          beforeLineStyle: LineStyle(
            color: Colors.black,
            thickness: 2,
          ),
          afterLineStyle: LineStyle(
            color: isLast ? Colors.transparent : Colors.black,
            thickness: 2,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['status']!,
                  style: TextStyle(
                    color: isCompleted ? Colors.black : Colors.grey[600],
                    fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
               Spacer(),
               SizedBox(height: 50,),
                Text(
                  event['time']!,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ),
        );
      }).toList(),
    ),
Container(
     width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    child:   Image.asset(AppImages.collecttorateicon,fit:BoxFit.fill,)
    )
            ],
          ),
        ),
      ),
    );
  }
}