import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_demo/constant/const.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloudDatabase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud FireStore'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('add'),
            onPressed: () {
              userCollection
                  .add({'name': 'hello', 'email': 'abc@gmail.com'}).catchError(
                (e) {
                  print('add error $e');
                },
              );
            },
          ),
          ElevatedButton(
            child: Text('update'),
            onPressed: () {
              userCollection.doc('cStSRoNfPJCZvx0emgrB').update(
                  {'name': 'hiiii', 'email': 'hello@gmail.com'}).catchError(
                (e) {
                  print('update error $e');
                },
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: userCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> _user = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: _user.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                userCollection
                                    .doc('${_user[index].id}')
                                    .update({
                                  'name': 'dhruvik',
                                  'email': 'hesddsfnsk'
                                }).catchError((e) {
                                  print('update error $e');
                                });
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                userCollection
                                    .doc('${_user[index].id}')
                                    .delete()
                                    .catchError((e) {
                                  print('delete error $e');
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        title: Text('${_user[index].get('name')}'),
                        subtitle: Text('${_user[index].get('email')}'),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
