part of media_gallery;

/// Fetches the given media thumbnail from the gallery.
class MediaThumbnailProvider extends ImageProvider<MediaThumbnailProvider> {
  MediaThumbnailProvider({
    @required this.media,
  }) : assert(media != null);

  Media? media;

  @override
  ImageStreamCompleter load(key, decode) {
    // ignore: unnecessary_null_comparison
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1.0,
      informationCollector: () sync* {
        yield ErrorDescription('Id: ${media?.id ?? 0}');
      },
    );
  }

  Future<ui.Codec> _loadAsync(
      MediaThumbnailProvider key, DecoderCallback decode) async {
    assert(key == this);
    if (media != null) {
      final bytes = await media!.getThumbnail();
      if (bytes.length == 0) return decode(Uint8List(0));

      if (bytes is Uint8List) {
        return await decode(bytes);
      }
    }
    return await decode(Uint8List(0));
  }

  @override
  Future<MediaThumbnailProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MediaThumbnailProvider>(this);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final MediaThumbnailProvider typedOther = other;
    if (media != null && typedOther.media != null) {
      return media!.id == typedOther.media!.id;
    }
    return false;
  }

  @override
  int get hashCode => media!.id.hashCode;

  @override
  String toString() => '$runtimeType("${media?.id ?? 0}")';
}

/// Fetches the given media collection thumbnail from the gallery.
class MediaCollectionThumbnailProvider
    extends ImageProvider<MediaCollectionThumbnailProvider> {
  MediaCollectionThumbnailProvider({
    @required this.collection,
  }) : assert(collection != null);

  MediaCollection? collection;

  @override
  ImageStreamCompleter load(key, decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1.0,
      informationCollector: () sync* {
        yield ErrorDescription('Id: ${collection?.id ?? 0}');
      },
    );
  }

  Future<ui.Codec> _loadAsync(
      MediaCollectionThumbnailProvider key, DecoderCallback decode) async {
    assert(key == this);
    if (collection != null) {
      final bytes = await collection!.getThumbnail();
      if (bytes.length == 0) return decode(Uint8List(0));
      if (bytes is Uint8List) {
        return await decode(bytes);
      }
    }
    return await decode(Uint8List(0));
  }

  @override
  Future<MediaCollectionThumbnailProvider> obtainKey(
      ImageConfiguration configuration) {
    return SynchronousFuture<MediaCollectionThumbnailProvider>(this);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final MediaCollectionThumbnailProvider typedOther = other;
    if (collection != null && typedOther.collection != null) {
      return collection!.id == typedOther.collection!.id;
    }
    return false;
  }

  @override
  int get hashCode => collection?.id.hashCode ?? 0;

  @override
  String toString() => '$runtimeType("${collection?.id ?? 0}")';
}

/// Fetches the given media image thumbnail from the gallery.
///
/// The given [media] must be of media type [MediaType.image].
class MediaImageProvider extends ImageProvider<MediaImageProvider> {
  MediaImageProvider({
    @required this.media,
  })  : assert(media != null),
        assert(media!.mediaType == MediaType.image);

  Media? media;

  @override
  ImageStreamCompleter load(key, decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1.0,
      informationCollector: () sync* {
        yield ErrorDescription('Id: ${media?.id ?? 0}');
      },
    );
  }

  Future<ui.Codec> _loadAsync(
      MediaImageProvider key, DecoderCallback decode) async {
    assert(key == this);
    if (media != null) {
      final file = await media!.getFile();
      // ignore: unnecessary_null_comparison
      if (file == null) return decode(Uint8List(0));

      final bytes = await file.readAsBytes();

      if (bytes.lengthInBytes == 0) return await decode(Uint8List(0));
      return await decode(bytes);
    }
    return await decode(Uint8List(0));
  }

  @override
  Future<MediaImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MediaImageProvider>(this);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final MediaImageProvider typedOther = other;
    if (media != null && typedOther.media != null)
      return media!.id == typedOther.media!.id;
    return false;
  }

  @override
  int get hashCode => media?.id.hashCode ?? 0;

  @override
  String toString() => '$runtimeType("${media?.id ?? 0}")';
}
