import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:send_notification/utils/repos/fcm_repo.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ValueNotifier valueNotifier = ValueNotifier<bool>(false);



  @override
  void initState() {

    super.initState();
  }
  @override
  void didChangeDependencies()async {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, isLoading, _) {
            return Center(
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.6,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    try {
                      valueNotifier.value = true;
                      var success = await FcmRepo.sendPushMessage();
                      if (success) {
                        Fluttertoast.showToast(
                            msg: "Notification sent..",
                            backgroundColor: Colors.green);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Something went wrong, please try again later",
                            backgroundColor: Colors.red);
                      }
                      valueNotifier.value = false;
                    } on Exception catch (e) {
                      Fluttertoast.showToast(
                          msg: e.toString(), backgroundColor: Colors.red);
                    }
                  },
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : const Text(
                          "send notification",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            );
          }),
    );
  }
}
