import 'package:flutter/material.dart';
import 'package:taxiflex/Screens/screens.dart';
import 'package:we_slide/we_slide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override

  Widget build(BuildContext context) {
    final double _panelMinSize = 70.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height * 0.80;
    final _controller = WeSlideController();
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
        controller: _controller,
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.green,
          child: Center(
            child: Text("Map Will Be Here"),
          ),
        ),
        panel: SearchSheet(controller: _controller),
        panelHeader: GestureDetector(
          onTap: () {
            _controller.show();
          },
          child: Container(
              alignment: Alignment.center,
              height: 70,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => _controller.show(),
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
