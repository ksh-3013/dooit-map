import 'package:dooit/common/colors.dart';
import 'package:dooit/common/fonts.dart';
import 'package:dooit/presentation/providers/my_provider.dart';
import 'package:flutter/material.dart';

class ChangeNameWidget extends StatefulWidget {
  const ChangeNameWidget({super.key, required this.userName});

  final String userName;

  @override
  State<ChangeNameWidget> createState() => _ChangeNameWidgetState();
}

class _ChangeNameWidgetState extends State<ChangeNameWidget> {

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myProvider.addListener(updateScreen);
    });
  }

  @override
  void dispose() {
    myProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFFF6EFE9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
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
                      Text('닉네임 변경', style: mediumText(size: 18, color: Colors.black),),
                      Spacer(),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 150,),
              Text('Dooit에서\n사용할 이름이에요', style: semiBoldText(size: 28, color: Colors.black), textAlign: TextAlign.center,),
              SizedBox(height: 40,),

              // 이름 입력창
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: myProvider.nameController,
                  textAlign: TextAlign.center,
                  style: semiBoldText(size: 30, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: widget.userName,
                    hintStyle: semiBoldText(size: 30, color: greyColor),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Text(myProvider.nameError, style: semiBoldText(size: 14, color: Colors.red),),
              SizedBox(height: 300,),

              // 변경하기 버튼
              GestureDetector(
                onTap: () async {
                  await myProvider.changeName();
                  if(myProvider.nameError.contains('성공')) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: pointColor,
                  ),
                  child: Text('변경하기', style: semiBoldText(size: 20, color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
