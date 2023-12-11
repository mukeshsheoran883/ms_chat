import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ms_chat/main.dart';
import 'package:ms_chat/ms_chat/api/apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final list = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ms Chat'),
          leading: Icon(
            Platform.isIOS ? CupertinoIcons.home : Icons.home,
            color: Colors.black,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () async {
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            },
            child: const Icon(Icons.add_comment),
          ),
        ),
        body: StreamBuilder(
          stream: APIs.fireStore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator(),);
              case ConnectionState.active:
              case ConnectionState.done:


                final data = snapshot.data?.docs;
                for (var i in data!) {
                  log('Data: ${jsonEncode(i.data())}');
                  list.add(i.data()['name'],);
                }

              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: mq.height * .01),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  // return ChatUserCard();
                  return Text('Name:${list[index]} ');
                },
              );
            }

          },
        ),
      ),
    );
  }
}
