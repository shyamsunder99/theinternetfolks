import 'package:flutter/material.dart';
import 'package:theinternetfolks/events_repo.dart';

import 'event.dart';

class EventsBloc extends ChangeNotifier {
  late Events events;
  var eventsRepo = EventsRepo();
  Future<Events> getEvents() async {
    return eventsRepo.getEvents();
  }
}
