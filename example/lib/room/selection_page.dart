import 'package:flutter/material.dart';
import 'package:twilio_programmable_video_example/room/join_preview_page.dart';
import 'package:twilio_programmable_video_example/room/join_room_page.dart';

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twilio Programmable Video'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: _buildOptions(context),
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _createRoom(context),
          child: Text('Create Room'),
        ),
        ElevatedButton(
          onPressed: () => _createPreview(context),
          child: Text('Create Preview'),
        ),
      ],
    );
  }

  Future<void> _createRoom(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute<JoinRoomPage>(
        fullscreenDialog: true,
        builder: (BuildContext context) => JoinRoomPage(),
      ),
    );
  }

  Future<void> _createPreview(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute<JoinPreviewPage>(
        fullscreenDialog: true,
        builder: (BuildContext context) => JoinPreviewPage(),
      ),
    );
  }
}
