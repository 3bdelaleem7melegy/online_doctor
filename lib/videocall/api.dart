// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI0MmI5ZWQ5Mi0xN2RkLTRkMjItODU2YS1mZjI5ZWI2ODQzM2QiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY5NzI5MDE3OSwiZXhwIjoxNzI4ODI2MTc5fQ.haFUc75B0og3DgZy05HEtvutCdcLiJt8y3wowr0Fd5E";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

//Destructuring the roomId from the response
  return json.decode(httpResponse.body)['roomId'];
}