import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:theinternetfolks/api_dart.dart';
import 'package:theinternetfolks/event.dart';
import 'package:theinternetfolks/event_detail.dart';
import 'package:theinternetfolks/search.dart';

import 'color.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => EventsBloc())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var eventsBloc = Provider.of<EventsBloc>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          titleSpacing: 30,
          elevation: 0,
          backgroundColor: MyColors.primaryColor,
          title: const Text(
            'Events',
            style: TextStyle(
              fontSize: 29,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w300,
              color: Color(0xff120D26),
            ),
          ),
          actions: [
            IconButton(
              color: Color(0xff120D26),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Icon(
              Icons.more_vert,
              color: Color(0xff120D26),
              size: 30,
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
      ),
      body: FutureBuilder<Events>(
        future: eventsBloc.getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            );
          }
          if (snapshot.data == null) {
            return SizedBox();
          }
          List<EventCard> eventCards = [];
          for (int i = 0; i < snapshot.data!.content.data.length; i++) {
            eventCards.add(EventCard(
              index: i,
              event: snapshot.data!.content.data[i],
              fullView: true,
            ));
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: eventCards,
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard(
      {Key? key,
      required this.index,
      required this.event,
      required this.fullView})
      : super(key: key);
  final int index;
  final Datum event;
  final bool fullView;
  @override
  Widget build(BuildContext context) {
    var format = DateFormat("E, MMM d • hh:mm a");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetailsScreen(
                      datum: event,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  event.organiserIcon,
                  errorBuilder: (context, error, stackTree) =>
                      SvgPicture.network(
                    event.organiserIcon,
                    height: 120,
                    width: 120,
                  ),
                  height: 120,
                  width: 120,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        format.format(event.dateTime),
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5669FF),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        event.title,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff120D26),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      (fullView)
                          ? Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: Color(0xffB0B1BC),
                                    size: 15,
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    event.venueName +
                                        ' • ' +
                                        event.venueCity +
                                        ',' +
                                        event.venueCountry,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff747688),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
