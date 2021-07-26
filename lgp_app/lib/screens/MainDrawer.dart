import 'package:flutter/material.dart';
import 'package:lgp_app/screens/AboutTheApp.dart';
import 'package:lgp_app/screens/EditProfile.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return new StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            String name = (snapshot.data as dynamic)['name'].toString();
            String useruid = (snapshot.data as dynamic)['useruid'].toString();
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Drawer(
                  child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 25),
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: AssetImage(
                                  "assets/images/profile_pic.jpeg",
                                ),
                              )),
                          Text(name,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                          Text("ID: $useruid",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfile()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text(
                      "About the App",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutTheApp()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_reaction),
                    title: Text(
                      "Let us know what you think!",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      return _launchURL();
                    },
                  ),
                ],
              ));
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  _launchURL() async {
    const url = 'https://forms.gle/RGYf89QVYuRFjoxB6';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
