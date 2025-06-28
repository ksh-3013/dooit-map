import 'package:flutter/material.dart';

import '../../../common/fonts.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // 상단
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
                      ),
                      Spacer(),
                      Text('포인트 몰', style: mediumText(size: 18, color: Colors.black),),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.search_rounded, size: 28, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
