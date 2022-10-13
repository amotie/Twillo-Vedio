import 'package:flutter/material.dart';
import 'package:twilio_programmable_video_example/room/join_preview_form.dart';

class JoinPreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twilio Programmable Video'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: JoinPreviewForm(),
        ),
      ),
    );
  }
}
