part of twilio_programmable_video;

/// Represents options for the preview before connecting to a [Room].
class PreviewOptions {
  /// Audio tracks that will be published upon connection.
  final LocalAudioTrack audioTrack;

  /// Video tracks that will be published upon connection.
  final LocalVideoTrack videoTrack;

  PreviewOptions({
    required this.audioTrack,
    required this.videoTrack,
  });

  /// Create a [PreviewOptionsModel] from properties.
  PreviewOptionsModel toModel() {
    return PreviewOptionsModel(
      audioTrack: audioTrack._toModel() as LocalAudioTrackModel,
      videoTrack: videoTrack._toModel() as LocalVideoTrackModel,
    );
  }
}
