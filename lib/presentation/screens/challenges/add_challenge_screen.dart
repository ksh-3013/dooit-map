import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/presentantion/providers/challenges/add_challenge_provider.dart';
import 'package:capstone_project_2/presentantion/screens/challenges/add_challenge_screen2.dart';
import 'package:capstone_project_2/presentantion/widgets/challenges/challenge_data_widget.dart';
import 'package:capstone_project_2/presentantion/widgets/challenges/challenge_info_widget.dart';
import 'package:capstone_project_2/presentantion/widgets/challenges/select_challenge_type_widget.dart';
import 'package:flutter/material.dart';

class AddChallengeScreen extends StatefulWidget {
  const AddChallengeScreen({super.key});

  @override
  State<AddChallengeScreen> createState() => _AddChallengeScreenState();
}

class _AddChallengeScreenState extends State<AddChallengeScreen> {
  final AddChallengeProvider provider = AddChallengeProvider();

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.addListener(updateScreen);
    });
  }

  @override
  void dispose() {
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFFF6EFE9),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: GestureDetector(
                  onTap: () {
                    switch(provider.pageIndex) {
                      case 0: Navigator.of(context).pop(); break;
                      case 1: provider.changeStep(0); break;
                      case 2: provider.changeStep(1); break;
                    }
                  },
                  child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 12,),
            // 단계 표시
            Row(
              children: [
                _sectionBar(index: 0),
                SizedBox(width: 10,),
                _sectionBar(index: 1),
                SizedBox(width: 10,),
                _sectionBar(index: 2),
              ],
            ),
            Expanded(child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: provider.pageController,
              children: [
                // 첫번째
                SelectChallengeTypeWidget(provider: provider),
                // 두번째
                ChallengeInfoWidget(provider: provider),
                // 세번째
                ChallengeDataWidget(provider: provider),
              ],
            )),
          ],
        ),
      ),
    ));
  }

  Widget _sectionBar({required int index}) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: index <= provider.pageIndex ? Colors.black : greyColor.withOpacity(0.5),
        ),
      ),
    );
  }
}
