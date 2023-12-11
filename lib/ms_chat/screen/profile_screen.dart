import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ms_chat/main.dart';
import 'package:ms_chat/ms_chat/api/apis.dart';
import 'package:ms_chat/ms_chat/model/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton.extended(
            onPressed: () async {
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: Column(
            children: [
              SizedBox(
                width: mq.width,
                height: mq.height * .05,
              ),
              // user profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  mq.height * 0.1,
                ),
                child: CachedNetworkImage(
                  width: mq.height * 0.2,
                  height: mq.height * 0.2,
                  fit: BoxFit.fill,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Text(
                widget.user.email,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: "eg. Happy Singh",
                    label: const Text('Name')),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "eg. Feeling Happy",
                  label: const Text('About'),
                ),
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: Size(mq.width * .5, mq.height * 0.06),
                ),
                onPressed: () {},
                icon: const Icon(Icons.edit,size: 28,),
                label: const Text('UPDATE',style: TextStyle(fontSize: 16),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
