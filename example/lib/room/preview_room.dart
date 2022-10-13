import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twilio_programmable_video/twilio_programmable_video.dart';
import 'package:twilio_programmable_video_example/models/twilio_enums.dart';
import 'package:twilio_programmable_video_example/room/room_bloc.dart';
import 'package:twilio_programmable_video_example/shared/services/backend_service.dart';

class PreviewRoom with ChangeNotifier {
  late CameraCapturer _cameraCapturer;
  late LocalVideoTrack? localVideoTrack;
  final _roomBloc = RoomBloc(backendService: FirebaseFunctionsService.instance);
  late Room _room;

  Future<void> init() async {
    await _initCameraCapturer();
    await _initVideoPreview();
  }

  Future<void> _initCameraCapturer() async {
    final sources = await CameraSource.getSources();
    _cameraCapturer = CameraCapturer(
      sources.firstWhere((source) => source.isBackFacing),
    );
  }

  Future<void> _initVideoPreview() async {
    localVideoTrack = LocalVideoTrack(
      true,
      _cameraCapturer,
      name: 'preview-video#1',
    );
    await localVideoTrack?.create();
  }

  Future<void> connect() async {
    _roomBloc.updateName('preview');
    _roomBloc.updateType(TwilioRoomType.groupSmall);
    await _roomBloc.submit();
    var connectOptions = ConnectOptions(
      _roomBloc.model.token ?? '',
      roomName: _roomBloc.model.name,
      dataTracks: [
        LocalDataTrack(
          DataTrackOptions(name: 'preview-data-track#1'),
        )
      ],
      videoTracks: [if (localVideoTrack != null) localVideoTrack!],
      preferredAudioCodecs: [OpusCodec()],
      networkQualityConfiguration: NetworkQualityConfiguration(
        remote: NetworkQualityVerbosity.NETWORK_QUALITY_VERBOSITY_MINIMAL,
      ),
      enableDominantSpeaker: true,
    );
    await _roomBloc.submit();
    _room = await TwilioProgrammableVideo.connect(connectOptions);
  }

  Future<void> publishPreview() async {
    await localVideoTrack?.publish();
  }

  Future<void> unpublishPreview() async {
    await localVideoTrack?.unpublish();
  }

  @override
  void dispose() {
    _room.disconnect();
    localVideoTrack?.release();
    localVideoTrack = null;
    super.dispose();
  }
}
