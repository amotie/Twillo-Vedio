import 'package:flutter/material.dart';
import 'package:twilio_programmable_video_example/room/preview_page.dart';

class JoinPreviewForm extends StatelessWidget {
  const JoinPreviewForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TextButton(onPressed: () => _submit(context), child: FittedBox(child: Text('Join Preview')))],
    );
  }

  Future<void> _submit(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute<PreviewPage>(
        fullscreenDialog: true,
        builder: (BuildContext context) => PreviewPage(),
      ),
    );
  }
}
