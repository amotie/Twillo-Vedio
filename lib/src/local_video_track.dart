part of twilio_programmable_video;

/// A local video track that gets video frames from a specified [VideoCapturer].
class LocalVideoTrack extends VideoTrack {
  final VideoCapturer _videoCapturer;

  /// Check if it is enabled.
  ///
  /// When the value is `false`, blank video frames are sent. When the value is `true`, frames from the [CameraCapturer] are provided.
  @override
  bool get isEnabled => super._enabled;

  /// Retrieves the [VideoCapturer].
  VideoCapturer get videoCapturer => _videoCapturer;

  LocalVideoTrack(enabled, this._videoCapturer, {String name = ''}) : super(enabled, name);

  /// Construct from a [LocalVideoTrackModel].
  factory LocalVideoTrack._fromModel(LocalVideoTrackModel model) {
    var videoCapturer = model.cameraCapturer.type == 'CameraCapturer' ? CameraCapturer._fromModel(model.cameraCapturer) : throw Exception('Received unknown VideoCapturer');
    var localVideoTrack = LocalVideoTrack(model.enabled, videoCapturer, name: model.name);
    localVideoTrack._updateFromModel(model);
    return localVideoTrack;
  }

  /// Dispose the videoCapturer
  void _dispose() {
    videoCapturer._dispose();
  }

  /// Create the local video track.
  Future<void> create() async {
    try {
      await ProgrammableVideoPlatform.instance.createVideoTrack(_toModel() as LocalVideoTrackModel);
    } on PlatformException catch (err) {
      throw TwilioProgrammableVideo._convertException(err);
    }
  }

  /// Set the state of the local video track.
  ///
  /// The results of this operation are signaled to other [Participant]s in the same [Room].
  /// When a video track is disabled, blank frames are sent in place of video frames from a video capturer.
  ///
  /// Throws [MissingParameterException] if [enabled] is not provided.
  /// Throws [NotFoundException] if no track is found by the name provided (probably means you haven't connected).
  Future<void> enable(bool enabled) async {
    try {
      await ProgrammableVideoPlatform.instance.enableVideoTrack(enabled, name);
      _enabled = enabled;
    } on PlatformException catch (err) {
      throw TwilioProgrammableVideo._convertException(err);
    }
  }

  /// Publish the local video track.
  ///
  /// The results of this operation are signaled to other [Participant]s in the same [Room].
  /// When a video track is disabled, blank frames are sent in place of video frames from a video capturer.
  ///
  /// Throws [MissingParameterException] if [enabled] is not provided.
  /// Throws [NotFoundException] if no track is found by the name provided (probably means you haven't connected).
  Future<void> publish() async {
    try {
      await ProgrammableVideoPlatform.instance.publishVideoTrack(name);
    } on PlatformException catch (err) {
      throw TwilioProgrammableVideo._convertException(err);
    }
  }

  /// Unpublish the local video track.
  ///
  /// The result of this operation stops signaling to other [Participant]s in the same [Room].
  Future<void> unpublish() async {
    try {
      await ProgrammableVideoPlatform.instance.unpublishVideoTrack(name);
    } on PlatformException catch (err) {
      throw TwilioProgrammableVideo._convertException(err);
    }
  }

  /// Release the local video track.
  Future<void> release() async {
    try {
      await ProgrammableVideoPlatform.instance.releaseVideoTrack(name);
    } on PlatformException catch (err) {
      throw TwilioProgrammableVideo._convertException(err);
    }
  }

  /// Returns a native widget.
  ///
  /// By default the widget will be mirrored, to change that set [mirror] to false.
  /// If you provide a [key] make sure it is unique among all [VideoTrack]s otherwise Flutter might send the wrong creation params to the native side.
  Widget widget({bool mirror = true, Key? key}) {
    key ??= const ValueKey('Twilio_LocalParticipant');

    return ProgrammableVideoPlatform.instance.createLocalVideoTrackWidget(
      mirror: mirror,
      key: key,
    );
  }

  /// Create [LocalVideoTrackModel] from properties.
  TrackModel _toModel() {
    final cameraCapturer = videoCapturer as CameraCapturer;
    return LocalVideoTrackModel(
      enabled: _enabled,
      name: name,
      cameraCapturer: CameraCapturerModel(cameraCapturer.source, 'CameraCapturer'),
    );
  }
}
