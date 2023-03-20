part of mapbox_gl;

class Line {
  @visibleForTesting
  Line(this._id, this._options);


  String get id => _id;

  LineOptions _options;

  LineOptions get options => _options;
}

class LineOptions {
  const LineOptions({
    this.lineJoin,
    this.lineOpacity,
    this.lineColor,
    this.lineWidth,
    this.lineGapWidth,
    this.lineOffset,
    this.lineBlur,
    this.linePattern,
    this.geometry,
    this.draggable,
  });

  final String lineJoin;
  final double lineOpacity;
  final String lineColor;
  final double lineWidth;
  final double lineGapWidth;
  final double lineOffset;
  final double lineBlur;
  final String linePattern;
  final List<LatLng> geometry;
  final bool draggable;

  static const LineOptions defaultOptions = LineOptions();

  LineOptions copyWith(LineOptions changes) {
    if (changes == null) {
      return this;
    }
    return LineOptions(
      lineJoin: changes.lineJoin ?? lineJoin,
      lineOpacity: changes.lineOpacity ?? lineOpacity,
      lineColor: changes.lineColor ?? lineColor,
      lineWidth: changes.lineWidth ?? lineWidth,
      lineGapWidth: changes.lineGapWidth ?? lineGapWidth,
      lineOffset: changes.lineOffset ?? lineOffset,
      lineBlur: changes.lineBlur ?? lineBlur,
      linePattern: changes.linePattern ?? linePattern,
      geometry: changes.geometry ?? geometry,
      draggable: changes.draggable ?? draggable,
    );
  }

  dynamic _toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('lineJoin', lineJoin);
    addIfPresent('lineOpacity', lineOpacity);
    addIfPresent('lineColor', lineColor);
    addIfPresent('lineWidth', lineWidth);
    addIfPresent('lineGapWidth', lineGapWidth);
    addIfPresent('lineOffset', lineOffset);
    addIfPresent('lineBlur', lineBlur);
    addIfPresent('linePattern', linePattern);
    addIfPresent('geometry', geometry?.map((LatLng latLng) => latLng._toJson())?.toList());
    addIfPresent('draggable', draggable);
    return json;
  }
}