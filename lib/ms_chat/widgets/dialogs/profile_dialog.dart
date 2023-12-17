import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_chat/main.dart';
import 'package:ms_chat/ms_chat/model/chat_user.dart';
import 'package:ms_chat/ms_chat/screen/view_profile_screen.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .35,
        child: Stack(
          children: [
            //user profile picture
            Positioned(
              top: mq.height * .05,
              left: mq.width * .11,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  mq.height * 0.55,
                ),
                child: CachedNetworkImage(
                  width: mq.width * 0.55,
                  height: mq.height * 0.28,
                  fit: BoxFit.cover,
                  imageUrl: user.image,
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
            ),

            //user name
            Positioned(
              top: mq.height * .014,
              left: mq.width * .04,
              width: mq.width * .6,
              child: Text(
                user.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            //info button
            Positioned(
                top: 6,
                right: 8,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ViewProfileScreen(user: user);
                      },
                    ));
                  },
                  minWidth: 0,
                  padding: const EdgeInsets.all(0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                    size: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
