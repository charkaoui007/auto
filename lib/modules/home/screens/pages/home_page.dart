import 'package:flutter/material.dart';

import '../../../../utils/services/rest_api_service.dart';

import '../../widgets/home_banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeBannerWidget(),
          Container(
            margin: const EdgeInsets.only(
              top: 24,
              bottom: 14,
              left: 20,
            ),
            width: double.infinity,
            child: const Text(
              "Classmates",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }


}
