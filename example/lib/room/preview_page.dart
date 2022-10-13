import 'package:flutter/material.dart';
import 'package:twilio_programmable_video/twilio_programmable_video.dart';
import 'package:twilio_programmable_video_example/room/preview_room.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  PreviewRoom? _previewRoom;

  @override
  void initState() {
    super.initState();
    _connectToPreview();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: _previewRoom?.localVideoTrack?.widget(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => {_previewRoom?.connect()},
              child: Text('Connect'),
            ),
            ElevatedButton(
              onPressed: () => {_previewRoom?.publishPreview()},
              child: Text('Publish'),
            ),
            ElevatedButton(
              onPressed: () => {_previewRoom?.unpublishPreview()},
              child: Text('Unpublish'),
            ),
          ],
        )
      ],
    );
  }

  void _connectToPreview() async {
    await TwilioProgrammableVideo.debug(dart: true, native: true);
    final previewRoom = PreviewRoom();
    await previewRoom.init();
    setState(() {
      _previewRoom = previewRoom;
      previewRoom.addListener(_previewRoomUpdated);
    });
  }

  void _previewRoomUpdated() {
    setState(() {});
  }

  @override
  void dispose() {
    _previewRoom?.removeListener(_previewRoomUpdated);
    _previewRoom?.dispose();
    super.dispose();
  }
}
