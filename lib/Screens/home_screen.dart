import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiflex/Screens/screens.dart';
import 'package:we_slide/we_slide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

    //* Google maps stuff
  final Completer<GoogleMapController> _mapController = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String? _darkMapStyle;
  String? _lightMapStyle;

    //* Changing map styles according to theme
  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('lib/Assets/map_styles/dark_map_style.json');
    _lightMapStyle = await rootBundle.loadString('lib/Assets/map_styles/light_map_style.json');
  }

  Future _setMapStyle() async {
    final controller = await _mapController.future;
    final theme = WidgetsBinding.instance.window.platformBrightness;
    if (theme == Brightness.dark) {
      controller.setMapStyle(_darkMapStyle);
    } else {
      controller.setMapStyle(_lightMapStyle);
    }
  }

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
  }

  @override
    void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget build(BuildContext context) {
    final double _panelMinSize = 70.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height * 0.80;
    final _slideController = WeSlideController();
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                _key.currentState!.openDrawer();
              },
            ),
          ),
        ),
        
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: WeSlide(
        panelBorderRadiusEnd: 15,
        hideFooter: true,
        isDismissible: true,
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        controller: _slideController,
        body: Stack(
          children: [SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(-26.236141931462093, 27.90543208051695),
                  zoom: 12),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
                _setMapStyle();
              },
              markers: Set<Marker>.of(markers.values),
            ),
          ),],
        ),
        panel: SearchSheet(controller: _slideController),
        panelHeader: GestureDetector(
          onTap: () {
            _slideController.show();
          },
          child: Container(
              alignment: Alignment.center,
              height: 70,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => _slideController.show(),
                  //TODO Probably find a better icon pack
                  icon: Icon(Icons.bus_alert_outlined),
                  label: Text(
                    "Plan a trip",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
