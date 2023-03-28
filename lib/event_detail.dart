import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'event.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({Key? key, required this.datum}) : super(key: key);
  final Datum datum;

  @override
  Widget build(BuildContext context) {
    var format = DateFormat("dd MMMM yyyy");
    var formats = DateFormat("EEEE,hh.mm a");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          title: const Text('Event Details'),
          flexibleSpace: SizedBox(
            height: 300,
            child: Image.network(
              datum.bannerImage,
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: Text(
                datum.title,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 35),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/events/organisation.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        datum.organiserName,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff0D0C26)),
                      ),
                      const Text(
                        'Organizer',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706E8F)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/events/calender.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        format.format(datum.dateTime),
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff0D0C26)),
                      ),
                      Text(
                        formats.format(datum.dateTime),
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706E8F)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/events/location.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        datum.venueName,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff0D0C26)),
                      ),
                      Text(
                        "${datum.venueCity},${datum.venueCountry}",
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706E8F)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: const Text(
                'About Event',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xff120D26)),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Text(
                datum.description,
                style: const TextStyle(
                    fontFamily: 'Inter', fontSize: 16, height: 1.5),
              ),
            ),
            Container()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 58,
        width: 300,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xff5669FF),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 12,
                child: Text(
                  'BOOK NOW',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xffFFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xff3D56F0)),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
