part of mapbox_gl;

typedef void MapCreatedCallback(MapboxMapController controller);

class MapboxMap extends StatefulWidget {
  const MapboxMap({
    @required this.initialCameraPosition,
    this.onMapCreated,
    this.gestureRecognizers,
    this.compassEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.styleString,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.trackCameraPosition = false,
    this.myLocationEnabled = false,
    this.myLocationTrackingMode = MyLocationTrackingMode.Tracking,
    this.logoViewMargins,
    this.compassViewMargins,
    this.attributionButtonMargins,
    this.onMapClick,
    this.onCameraTrackingDismissed,
    this.onCameraTrackingChanged,
  }) : assert(initialCameraPosition != null);

  final MapCreatedCallback onMapCreated;

  /// The initial position of the map's camera.
  final CameraPosition initialCameraPosition;

  /// True if the map should show a compass when rotated.
  final bool compassEnabled;

  /// Geographical bounding box for the camera target.
  final CameraTargetBounds cameraTargetBounds;

  /// Style URL or Style JSON
  /// Can be a MapboxStyle constant, any Mapbox Style URL,
  /// or a StyleJSON (https://docs.mapbox.com/mapbox-gl-js/style-spec/)
  final String styleString;

  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool trackCameraPosition;

  final bool myLocationEnabled;
  final MyLocationTrackingMode myLocationTrackingMode;

  final Point logoViewMargins;
  final Point compassViewMargins;
  final Point attributionButtonMargins;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  final OnMapClickCallback onMapClick;
  final OnCameraTrackingChangedCallback onCameraTrackingChanged;

  @override
  State createState() => _MapboxMapState();
}

class _MapboxMapState extends State<MapboxMap> {
  final Completer<MapboxMapController> _controller =
      Completer<MapboxMapController>();

  _MapboxMapOptions _mapboxMapOptions;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'initialCameraPosition': widget.initialCameraPosition?._toMap(),
      'options': _MapboxMapOptions.fromWidget(widget).toMap(),
    };
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins.flutter.io/mapbox_gl',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'plugins.flutter.io/mapbox_gl',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin');
  }

  @override
  void initState() {
    super.initState();
    _mapboxMapOptions = _MapboxMapOptions.fromWidget(widget);
  }

  @override
  void didUpdateWidget(MapboxMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    final _MapboxMapOptions newOptions = _MapboxMapOptions.fromWidget(widget);
    final Map<String, dynamic> updates =
        _mapboxMapOptions.updatesMap(newOptions);
    _updateOptions(updates);
    _mapboxMapOptions = newOptions;
  }

  void _updateOptions(Map<String, dynamic> updates) async {
    if (updates.isEmpty) {
      return;
    }
    final MapboxMapController controller = await _controller.future;
    controller._updateMapOptions(updates);
  }

  Future<void> onPlatformViewCreated(int id) async {
    final MapboxMapController controller = await MapboxMapController.init(
        id, widget.initialCameraPosition,
        onMapClick: widget.onMapClick,
        onCameraTrackingDismissed: widget.onCameraTrackingDismissed,
        onCameraTrackingChanged: widget.onCameraTrackingChanged);
    _controller.complete(controller);
    if (widget.onMapCreated != null) {
      widget.onMapCreated(controller);
    }
  }
}

class _MapboxMapOptions {
  _MapboxMapOptions({
    this.compassEnabled,
    this.cameraTargetBounds,
    this.styleString,
    this.minMaxZoomPreference,
    this.rotateGesturesEnabled,
    this.scrollGesturesEnabled,
    this.tiltGesturesEnabled,
    this.trackCameraPosition,
    this.zoomGesturesEnabled,
    this.myLocationEnabled,
    this.myLocationTrackingMode,
    this.logoViewMargins,
    this.compassViewMargins,
    this.attributionButtonMargins,
  });

  static _MapboxMapOptions fromWidget(MapboxMap map) {
    return _MapboxMapOptions(
      compassEnabled: map.compassEnabled,
      cameraTargetBounds: map.cameraTargetBounds,
      styleString: map.styleString,
      minMaxZoomPreference: map.minMaxZoomPreference,
      rotateGesturesEnabled: map.rotateGesturesEnabled,
      scrollGesturesEnabled: map.scrollGesturesEnabled,
      tiltGesturesEnabled: map.tiltGesturesEnabled,
      trackCameraPosition: map.trackCameraPosition,
      zoomGesturesEnabled: map.zoomGesturesEnabled,
      myLocationEnabled: map.myLocationEnabled,
      myLocationTrackingMode: map.myLocationTrackingMode,
      logoViewMargins: map.logoViewMargins,
      compassViewMargins: map.compassViewMargins,
      attributionButtonMargins: map.attributionButtonMargins
    );
  }

  final bool compassEnabled;

  final CameraTargetBounds cameraTargetBounds;

  final String styleString;

  final MinMaxZoomPreference minMaxZoomPreference;

  final bool rotateGesturesEnabled;

  final bool scrollGesturesEnabled;

  final bool tiltGesturesEnabled;

  final bool trackCameraPosition;

  final bool zoomGesturesEnabled;

  final bool myLocationEnabled;

  final MyLocationTrackingMode myLocationTrackingMode;

  final Point logoViewMargins;

  final Point compassViewMargins;

  final Point attributionButtonMargins;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> optionsMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        optionsMap[fieldName] = value;
      }
    }

    List<dynamic> pointToArray(Point fieldName) {
      if (fieldName != null) {
        return <dynamic>[fieldName.x, fieldName.y];
      }

      return null;
    }

    addIfNonNull('compassEnabled', compassEnabled);
    addIfNonNull('cameraTargetBounds', cameraTargetBounds?._toJson());
    addIfNonNull('styleString', styleString);
    addIfNonNull('minMaxZoomPreference', minMaxZoomPreference?._toJson());
    addIfNonNull('rotateGesturesEnabled', rotateGesturesEnabled);
    addIfNonNull('scrollGesturesEnabled', scrollGesturesEnabled);
    addIfNonNull('tiltGesturesEnabled', tiltGesturesEnabled);
    addIfNonNull('zoomGesturesEnabled', zoomGesturesEnabled);
    addIfNonNull('trackCameraPosition', trackCameraPosition);
    addIfNonNull('myLocationEnabled', myLocationEnabled);
    addIfNonNull('myLocationTrackingMode', myLocationTrackingMode?.index);
    addIfNonNull('logoViewMargins', pointToArray(logoViewMargins));
    addIfNonNull('compassViewMargins', pointToArray(compassViewMargins));
    addIfNonNull('attributionButtonMargins', pointToArray(attributionButtonMargins));
    return optionsMap;
  }

  Map<String, dynamic> updatesMap(_MapboxMapOptions newOptions) {
    final Map<String, dynamic> prevOptionsMap = toMap();
    return newOptions.toMap()..removeWhere((String key, dynamic value) => prevOptionsMap[key] == value);
  }
}