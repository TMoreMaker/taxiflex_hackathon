import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../Utils/utils.dart';
import '../helper/secrets.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(endpointUrl, defaultHeaders: {
          'Content-Type': 'application/json',
          'Authorization':
              stepzenAuthKey,
        }),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return _client;
  }
}
