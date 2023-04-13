import 'package:example/screens/steps_view.dart';
import 'package:example/utils/config/api_keys.dart';
import 'package:example/utils/extensions/context.dart';
import 'package:example/utils/navigation/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Distance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DistanceBetweenTwoPoints(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DistanceBetweenTwoPoints extends StatelessWidget {
  const DistanceBetweenTwoPoints({
    Key? key,
    this.leading = const Icon(Icons.place),
    this.title = "Distance between two points",
  }) : super(key: key);

  final Widget leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return const _DistanceBetweenTwoPoints();
  }
}

class _DistanceBetweenTwoPoints extends StatefulWidget {
  const _DistanceBetweenTwoPoints({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DistanceBetweenTwoPointsState();
}

class _DistanceBetweenTwoPointsState extends State<_DistanceBetweenTwoPoints> {
  _DistanceBetweenTwoPointsState();

  static const LatLng center = LatLng(6.1470738, 1.2170085);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  PolylinePoints polylinePoints = PolylinePoints();

  GoogleMapController? controller;
  LatLng? markerPosition;
  MarkerId? selectedMarker;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: center,
    zoom: 17.0,
  );

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  AddressPoint? _destination;
  Directions? _directions;
  String? _googleAPiKey;
  AddressPoint? _origin;
  List<Polyline>? _polylines;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  String get googleAPiKey => _googleAPiKey!;
  GoogleMapController get googleMapController => controller!;
  bool get loading => controller == null || _googleAPiKey == null;
  List<Polyline> get polylines => _polylines ?? [];
  DirectionRoute get shortestRoute => _directions!.shortestRoute;

  Future<void> load() async {
    await _setupApiKeys();
  }

  void _add(LatLng point) {
    final MarkerId markerId = MarkerId(point.toString());

    if (_origin == null) {
      _origin = AddressPoint(lat: point.latitude, lng: point.longitude);
    } else {
      _destination = AddressPoint(lat: point.latitude, lng: point.longitude);
    }

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(point.latitude, point.longitude),
      infoWindow: InfoWindow(
        title: "${point.latitude},${point.longitude}",
        snippet: point.toString(),
      ),
      onTap: () => _onMarkerTapped(markerId),
    );

    if (_origin != null && _destination != null) {
      _setupRoutes(_origin!, _destination!);
    }

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  Future<void> _setupApiKeys() async {
    _googleAPiKey = await googleAPIKey();
    GoogleMapsDirections.init(googleAPIKey: _googleAPiKey ?? "");
    setState(() {});
  }

  Future<void> _setupRoutes(AddressPoint p1, AddressPoint p2) async {
    _polylines = [];

    try {
      Directions directions = await getDirections(
        p1.lat,
        p1.lng,
        p2.lat,
        p2.lng,
        language: "fr_FR",
      );
      _directions = directions;

      List<PointLatLng> results = polylinePoints.decodePolyline(
        directions.routes.first.overviewPolyline.points,
      );

      LatLng origin = LatLng(p1.lat, p1.lng);
      LatLng destination = LatLng(p2.lat, p2.lng);
      final MarkerId originMarkerId = MarkerId(origin.toString());
      final MarkerId destinationMarkerId = MarkerId(destination.toString());

      setState(() {
        markers[originMarkerId] = Marker(
          markerId: originMarkerId,
          position: origin,
          infoWindow: InfoWindow(
            title: directions.shortestRoute.shortestLeg.startAddress,
            snippet: origin.toString(),
          ),
          onTap: () => _onMarkerTapped(originMarkerId),
        );
        markers[destinationMarkerId] = Marker(
          markerId: destinationMarkerId,
          position: destination,
          infoWindow: InfoWindow(
            title: directions.shortestRoute.shortestLeg.endAddress,
            snippet: destination.toString(),
          ),
          onTap: () => _onMarkerTapped(destinationMarkerId),
        );
      });

      if (results.isNotEmpty) {
        _polylines!.add(
          Polyline(
            width: 5,
            polylineId: PolylineId("${p1.lat}-${p1.lng}_${p2.lat}-${p2.lng}"),
            color: Colors.green,
            points: results
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
          ),
        );
      }
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition,
              markers: Set<Marker>.of(markers.values),
              polylines: Set.of(loading ? [] : polylines),
              zoomControlsEnabled: false,
              onTap: _add,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: (_destination == null ||
                      _origin == null ||
                      _directions == null)
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      height: 150,
                      width: context.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: context.width * 0.08,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      markers.remove(
                                        MarkerId(LatLng(
                                          _destination!.lat,
                                          _destination!.lng,
                                        ).toString()),
                                      );
                                      markers.remove(
                                        MarkerId(LatLng(
                                          _origin!.lat,
                                          _origin!.lng,
                                        ).toString()),
                                      );
                                      _destination = null;
                                      _origin = null;
                                      _directions = null;
                                      _polylines = [];
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                              ),
                              SizedBox(width: context.width * 0.045),
                              SizedBox(
                                width: context.width * 0.7,
                                child: TextFormField(
                                  initialValue:
                                      shortestRoute.shortestLeg.startAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: context.width * 0.1)
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: context.width * 0.7,
                                child: TextFormField(
                                  initialValue:
                                      shortestRoute.shortestLeg.endAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.12,
                                child: const IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.keyboard_double_arrow_up_sharp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: (_destination == null || _origin == null)
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                onPressed: () => googleMapController.animateCamera(
                  _directions == null
                      ? CameraUpdate.newCameraPosition(_initialCameraPosition)
                      : CameraUpdate.newLatLngBounds(
                          LatLngBounds(
                            southwest: LatLng(
                              _directions!.routes.first.bounds.southwest.lat,
                              _directions!.routes.first.bounds.southwest.lng,
                            ),
                            northeast: LatLng(
                              _directions!.routes.first.bounds.northeast.lat,
                              _directions!.routes.first.bounds.northeast.lng,
                            ),
                          ),
                          100.0,
                        ),
                ),
                child: const Icon(Icons.center_focus_strong),
              )
            : null,
        bottomSheet: (_destination == null || _origin == null)
            ? null
            : BottomSheet(
                onClosing: () {},
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.white,
                    height: 150,
                    width: context.width,
                    child: _directions == null
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${shortestRoute.shortestLeg.duration.text} (${shortestRoute.shortestLeg.distance.text})",
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(
                                "Route la plus rapide selon l'état actuel de la circulation (${shortestRoute.summary}).",
                                style: const TextStyle(fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.black45,
                                      elevation: 6,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: null,
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons
                                              .keyboard_double_arrow_right_outlined,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Apercu",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.green[900],
                                      elevation: 6,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: () => pushTo(
                                      context,
                                      RouteStepsView(route: shortestRoute),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.list,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Étapes",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.black45,
                                      elevation: 6,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: null,
                                    child: Row(
                                      children: const [
                                        Icon(
                                          CupertinoIcons.pin,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Épinglé",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                  );
                },
              ),
      ),
    );
  }
}
