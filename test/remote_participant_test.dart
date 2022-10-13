import 'package:flutter_test/flutter_test.dart';
import 'package:twilio_programmable_video/src/parts.dart';
import 'package:twilio_programmable_video_platform_interface/twilio_programmable_video_platform_interface.dart';

import 'mock_platform_interface.dart';
import 'model_instances.dart';

void main() {
  const roomModel = ModelInstances.roomModel;
  const remoteParticipantModel = ModelInstances.remoteParticipantModel;
  MockInterface? mockInterface;
  Room room;
  RemoteParticipant? remoteParticipant;

  setUp(() async {
    mockInterface = MockInterface();
    ProgrammableVideoPlatform.instance = mockInterface!;
    room = Room(0);

    mockInterface!.addRoomEvent(const ParticipantConnected(roomModel, remoteParticipantModel));
    final event = await room.onParticipantConnected.first;
    remoteParticipant = room.remoteParticipants.firstWhere(
      (RemoteParticipant p) => p.sid == event.remoteParticipant.sid,
      orElse: () => throw (Exception('Failed to get remoteParticipant')),
    );
  });

  group('.onAudioTrackDisabled', () {
    test('should process `RemoteAudioTrackDisabled` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteAudioTrackDisabled(
        remoteParticipantModel,
        ModelInstances.remoteAudioTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onAudioTrackDisabled.first;
      expect(event, isA<RemoteAudioTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteAudioTrackPublication.trackSid, ModelInstances.remoteAudioTrackPublicationModel.remoteAudioTrack!.sid);
    });
  });

  group('.onAudioTrackPublished', () {
    test('should process `RemoteAudioTrackPublished` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteAudioTrackPublished(
        remoteParticipantModel,
        ModelInstances.remoteAudioTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onAudioTrackPublished.first;
      expect(event, isA<RemoteAudioTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteAudioTrackPublication.trackSid, ModelInstances.remoteAudioTrackPublicationModel.remoteAudioTrack!.sid);
    });
  });

  group('.onAudioTrackSubscribed', () {
    test('should process `RemoteAudioTrackSubscribed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteAudioTrackSubscribed(
        remoteParticipantModel: remoteParticipantModel,
        remoteAudioTrackPublicationModel: ModelInstances.remoteAudioTrackPublicationModel,
        remoteAudioTrackModel: ModelInstances.remoteAudioTrackModel,
      ));
      final event = await remoteParticipant!.onAudioTrackSubscribed.first;
      expect(event, isA<RemoteAudioTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteAudioTrack.sid, ModelInstances.remoteAudioTrackPublicationModel.remoteAudioTrack!.sid);
    });
  });

  group('.onAudioTrackSubscriptionFailed', () {
    test('should process `RemoteAudioTrackSubscribed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteAudioTrackSubscriptionFailed(
        remoteParticipantModel: remoteParticipantModel,
        remoteAudioTrackPublicationModel: ModelInstances.remoteAudioTrackPublicationModel,
        exception: ModelInstances.twilioExceptionModel,
      ));
      final event = await remoteParticipant!.onAudioTrackSubscriptionFailed.first;
      expect(event, isA<RemoteAudioTrackSubscriptionFailedEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(
        event.remoteAudioTrackPublication.trackSid,
        ModelInstances.remoteAudioTrackPublicationModel.remoteAudioTrack!.sid,
      );
      expect(event.exception.code, ModelInstances.twilioExceptionModel.code);
    });
  });

  group('.onAudioTrackUnpublished', () {
    test('should process `RemoteAudioTrackUnpublished` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteAudioTrackUnpublished(
        remoteParticipantModel,
        ModelInstances.remoteAudioTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onAudioTrackUnpublished.first;
      expect(event, isA<RemoteAudioTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(
        event.remoteAudioTrackPublication.trackSid,
        ModelInstances.remoteAudioTrackPublicationModel.remoteAudioTrack!.sid,
      );
    });
  });

  group('.onAudioTrackUnsubscribed', () {
    test('should process `RemoteAudioTrackUnsubscribed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteAudioTrackUnsubscribed(
        remoteParticipantModel: remoteParticipantModel,
        remoteAudioTrackPublicationModel: ModelInstances.remoteAudioTrackPublicationModel,
        remoteAudioTrackModel: ModelInstances.remoteAudioTrackModel,
      ));
      final event = await remoteParticipant!.onAudioTrackUnsubscribed.first;
      expect(event, isA<RemoteAudioTrackSubscriptionEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteAudioTrack.sid, ModelInstances.remoteAudioTrackPublicationModel.remoteAudioTrack!.sid);
    });
  });

  group('.onDataTrackPublished', () {
    test('should process `RemoteDataTrackPublished` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteDataTrackPublished(
        remoteParticipantModel,
        ModelInstances.remoteDataTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onDataTrackPublished.first;
      expect(event, isA<RemoteDataTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteDataTrackPublication.trackSid, ModelInstances.remoteDataTrackPublicationModel.remoteDataTrack!.sid);
    });
  });

  group('.onDataTrackSubscribed', () {
    test('should process `RemoteDataTrackSubscribed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteDataTrackSubscribed(
        remoteParticipantModel: remoteParticipantModel,
        remoteDataTrackModel: ModelInstances.remoteDataTrackModel,
        remoteDataTrackPublicationModel: ModelInstances.remoteDataTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onDataTrackSubscribed.first;
      expect(event, isA<RemoteDataTrackSubscriptionEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteDataTrackPublication.trackSid, ModelInstances.remoteDataTrackPublicationModel.remoteDataTrack!.sid);
    });
  });

  group('.onDataTrackSubscriptionFailed', () {
    test('should process `RemoteDataTrackSubscriptionFailed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteDataTrackSubscriptionFailed(
        remoteParticipantModel: remoteParticipantModel,
        remoteDataTrackPublicationModel: ModelInstances.remoteDataTrackPublicationModel,
        exception: ModelInstances.twilioExceptionModel,
      ));
      final event = await remoteParticipant!.onDataTrackSubscriptionFailed.first;
      expect(event, isA<RemoteDataTrackSubscriptionFailedEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteDataTrackPublication.trackSid, ModelInstances.remoteDataTrackPublicationModel.remoteDataTrack!.sid);
      expect(event.exception.code, ModelInstances.twilioExceptionModel.code);
    });
  });

  group('.onDataTrackUnpublished', () {
    test('should process `RemoteDataTrackUnpublished` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteDataTrackUnpublished(
        remoteParticipantModel,
        ModelInstances.remoteDataTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onDataTrackUnpublished.first;
      expect(event, isA<RemoteDataTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteDataTrackPublication.trackSid, ModelInstances.remoteDataTrackPublicationModel.remoteDataTrack!.sid);
    });
  });

  group('.onDataTrackUnsubscribed', () {
    test('should process `RemoteDataTrackUnsubscribed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteDataTrackUnsubscribed(
        remoteParticipantModel: remoteParticipantModel,
        remoteDataTrackPublicationModel: ModelInstances.remoteDataTrackPublicationModel,
        remoteDataTrackModel: ModelInstances.remoteDataTrackModel,
      ));
      final event = await remoteParticipant!.onDataTrackUnsubscribed.first;
      expect(event, isA<RemoteDataTrackSubscriptionEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteDataTrackPublication.trackSid, ModelInstances.remoteDataTrackPublicationModel.remoteDataTrack!.sid);
    });
  });

  group('.onVideoTrackDisabled', () {
    test('should process `RemoteDataTrackSubscriptionFailed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteVideoTrackDisabled(
        remoteParticipantModel,
        ModelInstances.remoteVideoTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onVideoTrackDisabled.first;
      expect(event, isA<RemoteVideoTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteVideoTrackPublication.trackSid, ModelInstances.remoteVideoTrackPublicationModel.remoteVideoTrack!.sid);
    });
  });

  group('.onVideoTrackEnabled', () {
    test('should process `RemoteVideoTrackEnabled` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteVideoTrackEnabled(
        remoteParticipantModel,
        ModelInstances.remoteVideoTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onVideoTrackEnabled.first;
      expect(event, isA<RemoteVideoTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteVideoTrackPublication.trackSid, ModelInstances.remoteVideoTrackPublicationModel.remoteVideoTrack!.sid);
    });
  });

  group('.onVideoTrackPublished', () {
    test('should process `RemoteVideoTrackPublished` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteVideoTrackPublished(
        remoteParticipantModel,
        ModelInstances.remoteVideoTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onVideoTrackPublished.first;
      expect(event, isA<RemoteVideoTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteVideoTrackPublication.trackSid, ModelInstances.remoteVideoTrackPublicationModel.remoteVideoTrack!.sid);
    });
  });

  group('.onVideoTrackSubscribed', () {
    test('should process `RemoteVideoTrackSubscribed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteVideoTrackSubscribed(
        remoteParticipantModel: remoteParticipantModel,
        remoteVideoTrackModel: ModelInstances.remoteVideoTrackModel,
        remoteVideoTrackPublicationModel: ModelInstances.remoteVideoTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onVideoTrackSubscribed.first;
      expect(event, isA<RemoteVideoTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteVideoTrackPublication.trackSid, ModelInstances.remoteVideoTrackPublicationModel.remoteVideoTrack!.sid);
    });
  });

  group('.onVideoTrackSubscriptionFailed', () {
    test('should process `RemoteVideoTrackSubscriptionFailed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteVideoTrackSubscriptionFailed(
        remoteParticipantModel: remoteParticipantModel,
        remoteVideoTrackPublicationModel: ModelInstances.remoteVideoTrackPublicationModel,
        exception: ModelInstances.twilioExceptionModel,
      ));
      final event = await remoteParticipant!.onVideoTrackSubscriptionFailed.first;
      expect(event, isA<RemoteVideoTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteVideoTrackPublication.trackSid, ModelInstances.remoteVideoTrackPublicationModel.remoteVideoTrack!.sid);
    });
  });

  group('.onVideoTrackUnpublished', () {
    test('should process `RemoteVideoTrackUnpublished` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteVideoTrackUnpublished(
        remoteParticipantModel,
        ModelInstances.remoteVideoTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onVideoTrackUnpublished.first;
      expect(event, isA<RemoteVideoTrackEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteVideoTrackPublication.trackSid, ModelInstances.remoteVideoTrackPublicationModel.remoteVideoTrack!.sid);
    });
  });

  group('.onVideoTrackUnsubscribed', () {
    test('should process `RemoteVideoTrackSubscribed` correctly', () async {
      mockInterface!.addRemoteParticipantEvent(const RemoteVideoTrackUnsubscribed(
        remoteParticipantModel: remoteParticipantModel,
        remoteVideoTrackModel: ModelInstances.remoteVideoTrackModel,
        remoteVideoTrackPublicationModel: ModelInstances.remoteVideoTrackPublicationModel,
      ));
      final event = await remoteParticipant!.onVideoTrackUnsubscribed.first;
      expect(event, isA<RemoteVideoTrackSubscriptionEvent>());
      expect(event.remoteParticipant, remoteParticipant);
      expect(event.remoteVideoTrackPublication.trackSid, ModelInstances.remoteVideoTrackPublicationModel.remoteVideoTrack!.sid);
    });
  });
}
