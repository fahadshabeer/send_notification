
import 'dart:convert';

import 'package:http/http.dart' as http;

class FcmRepo
{
  static Future<bool> sendPushMessage()async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAjWsF8ps:APA91bHLMXWYpoXX_nVRhPLE5IkFIC1E_4JzshviUZB8mKF-4AaISbnejvrg6FKsh6qC-NlKMg2kckyukdb6BqynII5SzeRHBYSPuQYauCc-FZ6TwL3HHH95PNCnhDQjiRnqLOTK0Azj'
    };
    var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": "/topics/all",
      "data": {
        "time":DateTime.now().toUtc().toString(),
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }
    else {
      throw Exception(response.reasonPhrase);
    }

  }
}