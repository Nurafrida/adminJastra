import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Pesanan Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DaftarPesananAdmin(),
    );
  }
}

class DaftarPesananAdmin extends StatelessWidget {
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Pesanan Admin')),
      body: StreamBuilder<QuerySnapshot>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No orders available.'),
                SizedBox(height: 20),
                ExampleOrder(),
              ],
            ));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];
              return ListTile(
                title: Text(order['orderName']),
                subtitle: Text(order['orderDetails']),
              );
            },
          );
        },
      ),
    );
  }
}

class ExampleOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Example Order'),
        subtitle: Text('This is an example order detail.'),
      ),
    );
  }
}
