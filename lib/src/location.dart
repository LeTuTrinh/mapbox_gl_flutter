part of mapbox_gl;

class LatLng {
  /// [longitude].
  const LatLng(double latitude, double longitude)
      : assert(latitude != null),
        assert(longitude != null),
        latitude =
            (latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude)),
        longitude = (longitude + 180.0) % 360.0 - 180.0;
  final double latitude;
  final double longitude;

  dynamic _toJson() {
    return <double>[latitude, longitude];
  }

  static LatLng _fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return LatLng(json[0], json[1]);
  }

  @override
  String toString() => '$runtimeType($latitude, $longitude)';

  @override
  bool operator ==(Object o) {
    return o is LatLng && o.latitude == latitude && o.longitude == longitude;
  }

  @override
  int get hashCode => hashValues(latitude, longitude);
}

class LatLngBounds {
  LatLngBounds({@required this.southwest, @required this.northeast})
      : assert(southwest != null),
        assert(northeast != null),
        assert(southwest.latitude <= northeast.latitude);

  final LatLng southwest;
  final LatLng northeast;

  dynamic _toList() {
    return <dynamic>[southwest._toJson(), northeast._toJson()];
  }

  @visibleForTesting
  static LatLngBounds fromList(dynamic json) {
    if (json == null) {
      return null;
    }
    return LatLngBounds(
      southwest: LatLng._fromJson(json[0]),
      northeast: LatLng._fromJson(json[1]),
    );
  }

  @override
  String toString() {
    return '$runtimeType($southwest, $northeast)';
  }

  @override
  bool operator ==(Object o) {
    return o is LatLngBounds &&
        o.southwest == southwest &&
        o.northeast == northeast;
  }

  @override
  int get hashCode => hashValues(southwest, northeast);
}
