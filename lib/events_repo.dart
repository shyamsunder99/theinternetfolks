import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:theinternetfolks/event.dart';

class EventsRepo {
  Future<Events> getEvents() async {
    var apiClient = http.Client();

    var uri = Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event');
    var response = await apiClient.get(uri);
    Events x = Events.fromJson(jsonDecode(response.body));
    return x;
  }
}
