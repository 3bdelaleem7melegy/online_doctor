// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:online_doctor/videocall/meeting_control.dart';
import 'package:online_doctor/videocall/participant.dart';
import 'package:videosdk/videosdk.dart';


class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;

  Map<String, Participant> participants = {};

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: "John Doe",
      micEnabled: micEnabled,
      camEnabled: camEnabled,
      defaultCameraIndex:
      1, // Index of MediaDevices will be used to set default camera
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  // listening to meeting events
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      setState(() {
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    _room.on(
      Events.participantJoined,
          (Participant participant) {
        setState(
              () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
              () => participants.remove(participantId),
        );
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/JoinScreen'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Video Call',style: TextStyle(fontSize: 30,color: Colors.black),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.meetingId),
              //render all participant
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return ParticipantTile(
                          key: Key(participants.values.elementAt(index).id),
                          participant: participants.values.elementAt(index));
                    },
                    itemCount: participants.length,
                  ),
                ),
              ),
              MeetingControls(
                onToggleMicButtonPressed: () {
                  micEnabled ? _room.muteMic() : _room.unmuteMic();
                  micEnabled = !micEnabled;
                },
                onToggleCameraButtonPressed: () {
                  camEnabled ? _room.disableCam() : _room.enableCam();
                  camEnabled = !camEnabled;
                },
                onLeaveButtonPressed: () {
                  _room.leave();
                },
              ),
            ],
          ),
        ),
      ),
      // key: JoinScreen(),
    );
  }
}
