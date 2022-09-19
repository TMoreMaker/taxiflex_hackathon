import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../Services/services.dart';

class AllRoutesScreen extends StatelessWidget {
  const AllRoutesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShortRouteService shortRouteService =
        Provider.of<ShortRouteService>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All Routes"),
      ),
      body: StreamBuilder(
        stream: shortRouteService.readAllShortRoutes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GroupedListView(
              elements: snapshot.data!,
              groupSeparatorBuilder: (value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              itemBuilder: (context, element) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      tileColor: Theme.of(context).cardColor,
                      trailing: const Icon(
                        Icons.bookmark_border_outlined,
                      ),
                      leading: const Icon(
                        Icons.circle,
                        color: Colors.green,
                      ),
                      title: Text(element.endLocation),
                    ),
                  ),
                );
              },
              groupBy: (element) => element.startLocation,
            );
          }
          if (!snapshot.hasData) return Container();
          return Container();
        },
      ),
    );
  }
}
