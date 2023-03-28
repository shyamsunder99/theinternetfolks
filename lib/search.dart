import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'api_dart.dart';
import 'color.dart';
import 'event.dart';
import 'main.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    search(e) {
      setState(() {
        searchText = e;
      });
    }

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
                //Navigator.push(context,
                // MaterialPageRoute(builder: (context) => SearchScreen()));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 27, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.search,
                    size: 30,
                    color: Color(0xff5669FF),
                  ),
                  const SizedBox(
                    height: 25,
                    child: VerticalDivider(
                      color: Color(0xff7974E7),
                      thickness: 2,
                      width: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: search,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Type Event Name',
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400),
                      ),
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<Events>(
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
                  if (searchText != "" &&
                      snapshot.data!.content.data[i].title
                          .toLowerCase()
                          .contains(searchText)) {
                    eventCards.add(EventCard(
                      index: i,
                      event: snapshot.data!.content.data[i],
                      fullView: false,
                    ));
                  } else if (searchText == "") {
                    eventCards.add(EventCard(
                      index: i,
                      event: snapshot.data!.content.data[i],
                      fullView: false,
                    ));
                  }
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
          ],
        ),
      ),
    );
  }
}
