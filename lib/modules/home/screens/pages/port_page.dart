import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../constants/app_routes.dart';
import '../../../../utils/services/local_storage_service.dart';

class PortPage extends StatefulWidget {
  const PortPage({Key? key}) : super(key: key);

  @override
  State<PortPage> createState() => _PortPageState();
}

class _PortPageState extends State<PortPage> {

  int _counter = 0;

  void _incrementCounter() {
  setState(() {
  _counter++;
  });
  }

  List<Map<String, dynamic>> cardData = [
  {
  'name': 'GITHUB',
  'text': 'chakaoui 007',
  'redirectLink': 'https://github.com/charkaoui007',
  'icon': FontAwesome.github,
  },
  {
  'name': 'LINKEDIN',
  'text': 'anass chark',
  'redirectLink': 'https://www.linkedin.com',
  'icon': FontAwesome.linkedin_square,
  },
  {
  'name': 'VARIABLE ICON',
  'text': 'Variable Icon Card',
  'redirectLink': 'https://example.com',
  'icon': MaterialIcons.camera,
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Colors.cyan,
                  Colors.indigo.shade800,
                ],
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Anass CHARKAOUI",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: const Text(
                          "11181048",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Text(
                        "Informatika 2018",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        child: CircleAvatar(
                          foregroundImage: AssetImage('assets/1.png'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ListView.builder(
            itemCount: cardData.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String name = cardData[index]['name']!;
              String text = cardData[index]['text']!;
              Color color = index % 2 == 0 ? Colors.indigo : Colors.green;
              String redirectLink = cardData[index]['redirectLink']!;
              IconData icon = cardData[index]['icon']!;

              return GestureDetector(
                onTap: () async {
                  if (await canLaunch(redirectLink)) {
                    await launch(redirectLink);
                  } else {
                    print('Could not launch $redirectLink');
                  }
                },
                child: Container(
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                color: Colors.black,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () async {
                            if (await canLaunch(redirectLink)) {
                              await launch(redirectLink);
                            } else {
                              print('Could not launch $redirectLink');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Perform logout logic here
                    // For example, clear user session, navigate to login screen, etc.
                    LocalStorageService.setStateLogin(false);
                    Navigator.popAndPushNamed(context, AppRoutes.login);
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}