import 'package:expense_tracker/notification_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  List<Notification> notifications = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 39, 103),
        foregroundColor: Colors.white,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
          icon: Icon(Icons.arrow_back),
          splashColor: Colors.transparent,
        ),
        title: Text(
          'Notification',
        ),
      ),
      body: notifications.isEmpty
          ? Center(child: LottieBuilder.asset('assets/nonotification.json'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Dismissible(
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        // padding: EdgeInsets.only(right: 20),
                        // margin: EdgeInsets.symmetric(
                        //     horizontal: Theme.of(context).cardTheme.margin!.horizontal),
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      key: UniqueKey(),
                      child: NotificationContent()),
                );
              }),
    );
  }
}
