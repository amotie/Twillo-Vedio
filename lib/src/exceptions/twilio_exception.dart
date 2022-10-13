part of twilio_programmable_video;

/// Twilio Video SDK Exception.
class TwilioException implements Exception {
  /// This exception is iOS only.
  static const int unknownException = 0;
  static const int accessTokenInvalidException = 20101;
  static const int accessTokenHeaderInvalidException = 20102;
  static const int accessTokenIssuerInvalidException = 20103;
  static const int accessTokenExpiredException = 20104;
  static const int accessTokenNotYetValidException = 20105;
  static const int accessTokenGrantsInvalidException = 20106;
  static const int accessTokenSignatureInvalidException = 20107;
  static const int signalingConnectionErrorException = 53000;
  static const int signalingConnectionDisconnectedException = 53001;
  static const int signalingConnectionTimeoutException = 53002;
  static const int signalingIncomingMessageInvalidException = 53003;
  static const int signalingOutgoingMessageInvalidException = 53004;
  static const int signalingDnsResolutionErrorException = 53005;
  static const int signalingServerBusyException = 53006;
  static const int roomNameInvalidException = 53100;
  static const int roomNameTooLongException = 53101;
  static const int roomNameCharsInvalidException = 53102;
  static const int roomCreateFailedException = 53103;
  static const int roomConnectFailedException = 53104;
  static const int roomMaxParticipantsExceededException = 53105;
  static const int roomNotFoundException = 53106;
  static const int roomMaxParticipantsOutOfRangeException = 53107;
  static const int roomTypeInvalidException = 53108;
  static const int roomTimeoutOutOfRangeException = 53109;
  static const int roomStatusCallbackMethodInvalidException = 53110;
  static const int roomStatusCallbackInvalidException = 53111;
  static const int roomStatusInvalidException = 53112;
  static const int roomRoomExistsException = 53113;
  static const int roomInvalidParametersException = 53114;
  static const int roomMediaRegionInvalidException = 53115;
  static const int roomMediaRegionUnavailableException = 53116;
  static const int roomSubscriptionOperationNotSupportedException = 53117;
  static const int roomRoomCompletedException = 53118;
  static const int roomAccountLimitExceededException = 53119;
  static const int participantIdentityInvalidException = 53200;
  static const int participantIdentityTooLongException = 53201;
  static const int participantIdentityCharsInvalidException = 53202;
  static const int participantMaxTracksExceededException = 53203;
  static const int participantNotFoundException = 53204;
  static const int participantDuplicateIdentityException = 53205;
  static const int participantAccountLimitExceededException = 53206;
  static const int participantInvalidSubscribeRuleException = 53215;
  static const int trackInvalidException = 53300;
  static const int trackNameInvalidException = 53301;
  static const int trackNameTooLongException = 53302;
  static const int trackNameCharsInvalidException = 53303;
  static const int trackNameIsDuplicatedException = 53304;
  static const int trackServerTrackCapacityReachedException = 53305;
  static const int trackDataTrackMessageTooLargeException = 53306;
  static const int trackDataTrackSendBufferFullException = 53307;
  static const int mediaClientLocalDescFailedException = 53400;
  static const int mediaServerLocalDescFailedException = 53401;
  static const int mediaClientRemoteDescFailedException = 53402;
  static const int mediaServerRemoteDescFailedException = 53403;
  static const int mediaNoSupportedCodecException = 53404;
  static const int mediaConnectionErrorException = 53405;
  static const int mediaDataTrackFailedException = 53406;
  static const int mediaDtlsTransportFailedException = 53407;
  static const int mediaIceRestartNotAllowedException = 53408;
  static const int configurationAcquireFailedException = 53500;
  static const int configurationAcquireTurnFailedException = 53501;

  /// Code indicator, should match any of the [TwilioException] static properties.
  final int code;

  /// Message containing a short explanation.
  final String? message;

  const TwilioException(this.code, this.message);

  @override
  String toString() {
    return 'TwilioException: code: $code, message: $message';
  }

  /// Construct from a [TwilioExceptionModel].
  factory TwilioException._fromModel(TwilioExceptionModel model) {
    return TwilioException(model.code, model.message);
  }
}
