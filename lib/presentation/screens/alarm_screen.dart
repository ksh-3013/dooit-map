import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Row(
                children: [
                  Text(
                    '알림',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel_outlined, size: 35),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Divider(),
                ListTile(title: Text('data'), onTap: () {}),
                Divider(),
                ListTile(title: Text('data'), onTap: () {}),
                Divider(),
                ListTile(title: Text('data'), onTap: () {}),
                Divider(),
                ListTile(title: Text('data'), onTap: () {}),
                Divider(),
                ListTile(title: Text('data'), onTap: () {}),
                Divider(),
                ListTile(title: Text('data'), onTap: () {}),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
