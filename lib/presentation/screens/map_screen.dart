import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late KakaoMapController _mapController;
  // const 빼고 일반 생성자로 바꿔라
  LatLng _center = LatLng(37.566535, 126.977969);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dooit Kakao Map')),
      body: KakaoMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        center: _center, // 이 프로퍼티로만 초기 중심을 바꿀 수 있음 :contentReference[oaicite:1]{index=1}
        // 필요한 경우 markers, clusterer 등 추가
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 카메라 이동 대신 center 값 바꿔 재빌드
          setState(() {
            _center = LatLng(37.566535, 126.977969);
          });
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
