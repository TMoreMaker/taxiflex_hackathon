import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/models.dart';
import '../Services/services.dart';

class PastOrdersScreen extends StatefulWidget {
  const PastOrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PastOrdersScreen> createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getRiderDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    OrderServices orderServices = Provider.of<OrderServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: orderServices.readRiderOrders(
            userId: "xVrNmBnOpxTaIQLrhtOW7sYqn6N2"),
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].orderID),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Data Is Null"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].orderID),
                  leading: Icon(Icons.numbers),
                  subtitle: Text(DateFormat('dd-MMM-yyy').format(snapshot.data![index].createdAt.toDate())),
                );
              },
            );
          }
        },
      ),
    );
  }
}
