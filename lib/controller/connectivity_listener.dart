import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/services/connectivity_service.dart';
import 'package:mdabali_report/view/no_internet_page.dart';

class ConnectivityListener extends StatefulWidget {
  final Widget child;
  const ConnectivityListener({super.key, required this.child});

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  bool _isNoInternetPageShown = false;
  Timer? _debounceTimer;
  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkInitialConnectivity() async {
    final isConnected = await ConnectivityService.isConnected();
    if (!isConnected && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNoInternetPage();
      });
    }
  }

  void _showNoInternetPage() {
    if (!_isNoInternetPageShown && mounted) {
      print(
          'Pushing NoInternetPage, isShown: $_isNoInternetPageShown, route: ${Get.currentRoute}');
      setState(() {
        _isNoInternetPageShown = true;
      });
      Get.to(
        () => const NoInternetPage(),
        routeName: '/NoInternetPage',
        preventDuplicates: false,
      );
    }
  }

  void _hideNoInternetPage() {
    if (_isNoInternetPageShown &&
        Get.currentRoute == '/NoInternetPage' &&
        mounted) {
      print(
          'Popping NoInternetPage, isShown: $_isNoInternetPageShown'); // Debug log
      setState(() {
        _isNoInternetPageShown = false;
      });
      Get.back();
    }
  }

  void _handleConnectivityChange(bool isConnected) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (isConnected) {
        _hideNoInternetPage();
      } else {
        _showNoInternetPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
        stream: ConnectivityService.connectivityStream,
        builder: (context, snapshot) {
          final isConnected = snapshot.hasData
              ? !snapshot.data!.contains(ConnectivityResult.none)
              : true;
          print(
              'Snapshot: ${snapshot.data}, isConnected: $isConnected, currentRoute: ${Get.currentRoute}');
          WidgetsBinding.instance.addPersistentFrameCallback((_) {
            _handleConnectivityChange(isConnected);
          });
          return widget.child;
        });
  }
}
