part of mapbox_gl;

class MapboxStyles {
  static const String MAPBOX_STREETS = "mapbox://styles/mapbox/streets-v11";


  static const String OUTDOORS = "mapbox://styles/mapbox/outdoors-v11";
  static const String LIGHT = "mapbox://styles/mapbox/light-v10";
  static const String DARK = "mapbox://styles/mapbox/dark-v10";
  /// improve the style.
  static const String SATELLITE_STREETS = "mapbox://styles/mapbox/satellite-streets-v11";
  static const String TRAFFIC_DAY = "mapbox://styles/mapbox/traffic-day-v2";
  static const String TRAFFIC_NIGHT = "mapbox://styles/mapbox/traffic-night-v2";
}
enum MyLocationTrackingMode {
  None,
  Tracking,
  TrackingCompass,
  TrackingGPS,
}

class CameraTargetBounds {
  const CameraTargetBounds(this.bounds);

  final LatLngBounds bounds;

  static const CameraTargetBounds unbounded = CameraTargetBounds(null);

  dynamic _toJson() => <dynamic>[bounds?._toList()];

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final CameraTargetBounds typedOther = other;
    return bounds == typedOther.bounds;
  }

  @override
  int get hashCode => bounds.hashCode;

  @override
  String toString() {
    return 'CameraTargetBounds(bounds: $bounds)';
  }
}

class MinMaxZoomPreference {
  const MinMaxZoomPreference(this.minZoom, this.maxZoom)
      : assert(minZoom == null || maxZoom == null || minZoom <= maxZoom);
  final double minZoom;

  final double maxZoom;

  static const MinMaxZoomPreference unbounded =
      MinMaxZoomPreference(null, null);

  dynamic _toJson() => <dynamic>[minZoom, maxZoom];

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final MinMaxZoomPreference typedOther = other;
    return minZoom == typedOther.minZoom && maxZoom == typedOther.maxZoom;
  }

  @override
  int get hashCode => hashValues(minZoom, maxZoom);

  @override
  String toString() {
    return 'MinMaxZoomPreference(minZoom: $minZoom, maxZoom: $maxZoom)';
  }
}
