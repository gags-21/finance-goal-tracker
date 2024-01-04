import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth currentUserAuth = FirebaseAuth.instance;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // profile
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                currentUserAuth.currentUser!.photoURL ?? '',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              currentUserAuth.currentUser!.displayName ?? "",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(
              height: 50,
            ),
            // logout btn
            InkWell(
              onTap: () async {
                await currentUserAuth.signOut();
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 75, 75),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
