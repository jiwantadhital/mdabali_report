import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final _connectivity = Connectivity();
  static Stream<List<ConnectivityResult>> get connectivityStream=> _connectivity.onConnectivityChanged;

  static Future<bool> isConnected()async{
    final result= await _connectivity.checkConnectivity();
    print('Internet Check');
    return !result.contains(ConnectivityResult.none);
  
  }
}