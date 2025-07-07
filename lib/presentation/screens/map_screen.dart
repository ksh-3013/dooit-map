import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  InAppWebViewController? webViewController;
  StreamSubscription<Position>? positionStream;

  String _searchKeyword = "";
  bool isGymSelected = false;
  DateTime? checkinStartTime;
  Timer? _timer;
  Duration? elapsed;
  bool isCheckedIn = false;
  Map<String, dynamic>? checkoutResult;
  LatLng? checkedInLocation;

  Future<Position?> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition();
  }

  void startCheckinTimer(DateTime start, Position pos) {
    checkinStartTime = start;
    checkedInLocation = LatLng(pos.latitude, pos.longitude);
    isCheckedIn = true;
    elapsed = Duration.zero;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final diff = now.difference(checkinStartTime!);
      setState(() {
        elapsed = diff;
      });
    });
  }

  void _handlePositionUpdate(Position pos) {
    webViewController?.evaluateJavascript(
      source: 'moveToLocationWithHeading(${pos.latitude}, ${pos.longitude}, ${pos.heading});',
    );

    if (isCheckedIn && checkedInLocation != null) {
      final distance = Geolocator.distanceBetween(
        checkedInLocation!.latitude,
        checkedInLocation!.longitude,
        pos.latitude,
        pos.longitude,
      );
      if (distance > 200) {
        print("자동 체크아웃 - 200m 이상 벗어남");
        _checkout();
      }
    }
  }

  void _moveMapToCurrentLocation(Position position) {
    final lat = position.latitude;
    final lng = position.longitude;
    final js = 'moveToLocation($lat, $lng);';
    webViewController?.evaluateJavascript(source: js);
  }

  Future<void> _checkout() async {
    if (elapsed == null || elapsed!.inMinutes < 1) return;
    final minutes = elapsed!.inMinutes;

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = pref.getString('accessToken');
      if (accessToken == null || accessToken.isEmpty) return;

      final res = await http.post(
        Uri.parse('https://be-production-e1c4.up.railway.app/api/exer/checkout'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode({"min": minutes}),
      );

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        setState(() {
          isCheckedIn = false;
          checkoutResult = decoded['data'];
          elapsed = null;
          _timer?.cancel();
          _timer = null;
        });
      }
    } catch (e) {
      print("에러 발생: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen(_handlePositionUpdate);
  }

  @override
  void dispose() {
    positionStream?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: (val) => _searchKeyword = val,
              decoration: InputDecoration(
                hintText: "검색어를 입력해주세요",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              if (_searchKeyword.trim().isNotEmpty) {
                webViewController?.evaluateJavascript(
                  source: "searchPlace('${_searchKeyword.trim()}');",
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons() {
    return Row(
      children: [
        if (isGymSelected)
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                Position? pos = await _determinePosition();
                if (pos != null) {
                  webViewController?.evaluateJavascript(source: 'markAsCheckedIn();');
                  startCheckinTimer(DateTime.now(), pos);
                }
              },
              icon: Icon(Icons.calendar_today, color: Colors.white),
              label: Text("Check-in", style: TextStyle(color: Colors.white)),
            ),
          ),
        if (isGymSelected) SizedBox(width: 12),
        if (isCheckedIn)
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _checkout,
              icon: Icon(Icons.logout, color: Colors.black),
              label: Text("체크아웃", style: TextStyle(color: Colors.black)),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri("https://dooit-bf5a9.web.app?version=\${DateTime.now().millisecondsSinceEpoch}"),
            ),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;

              controller.addJavaScriptHandler(
                handlerName: 'gymSelected',
                callback: (args) {
                  bool selected = args.first == true;
                  setState(() {
                    isGymSelected = selected;
                  });
                },
              );

              controller.addJavaScriptHandler(
                handlerName: 'checkinTime',
                callback: (args) {
                  // 이 부분은 현재 사용하지 않음
                },
              );
            },
            onLoadStop: (controller, url) async {
              Position? pos = await _determinePosition();
              if (pos != null) {
                _moveMapToCurrentLocation(pos);
              }
            },
          ),

          Positioned(top: 50, left: 0, right: 0, child: _buildSearchBar()),

          if (elapsed != null)
            Positioned(
              top: 110,
              left: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${elapsed!.inMinutes}분 ${elapsed!.inSeconds % 60}초',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

          if (checkoutResult != null)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("운동 기록 완료", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("추가 시간: ${checkoutResult!['min']}분", style: TextStyle(color: Colors.white)),
                    Text("오늘 누적: ${checkoutResult!['today_total_time']}분", style: TextStyle(color: Colors.white)),
                    Text("총 운동: ${checkoutResult!['total_time']}분", style: TextStyle(color: Colors.white)),
                    Text("획득 포인트: ${checkoutResult!['point']}", style: TextStyle(color: Colors.white)),
                    Text("총 포인트: ${checkoutResult!['total_point']}", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),

          if (isCheckedIn || isGymSelected)
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: _buildBottomActionButtons(),
            ),
        ],
      ),
    );
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}
