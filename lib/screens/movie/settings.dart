import 'package:flutter/material.dart';
import 'package:flutter_movie/utils/text.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30.0),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Jane Doe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          "Nepal",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),  
            ),
            
            const SizedBox(height: 20.0),
            ListTile(
              title: const ModifiedText(
                text: "Languages",
                size: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              subtitle: ModifiedText(
                text: "English US",
                size: 14,
                color: Colors.grey,
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey.shade400,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const ModifiedText(
                text: "Profile Settings",
                size: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              subtitle: ModifiedText(
                text: "Jana D",
                size: 14,
                color: Colors.grey,
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey.shade400,
              ),
              onTap: () {},
            ),
            SwitchListTile(
              title: const ModifiedText(
                text: "Email Notifications",
                size: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              subtitle: ModifiedText(
                text: "On",
                size: 14,
                color: Colors.grey,
                textAlign: TextAlign.left,
              ),
              value: true,
              onChanged: (val) {},
            ),
            SwitchListTile(
              title: const ModifiedText(
                text: "Push Notifications",
                size: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              subtitle:  ModifiedText(
                text: "Off",
                size: 14,
                color: Colors.grey,
                textAlign: TextAlign.left,
              ),
              value: false,
              onChanged: (val) {},
            ),
            ListTile(
              title: const ModifiedText(
                text: "LogOut",
                size: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}