import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mdabali_report/bloc/Auth/auth_bloc.dart';
import 'package:mdabali_report/bloc/Auth/auth_event.dart';

class CustomHttpInterceptor extends http.BaseClient{
  final http.Client _innerClient= http.Client();
  final AuthBloc authBloc;
  bool _hasTriggeredLogout = false;
  CustomHttpInterceptor(this.authBloc);
  
  @override
  Future<http.StreamedResponse>send(http.BaseRequest request)async{
 print('CustomHttpClient: Sending request to ${request.url}');
 final response=await _innerClient.send(request);
 final responseBytes= await response.stream.toBytes();
 final responseString= utf8.decode(responseBytes,allowMalformed: true);
 final httpResponse= http.Response(responseString,
 response.statusCode,
 headers: response.headers,
 request: response.request,
 persistentConnection: response.persistentConnection,
 reasonPhrase: response.reasonPhrase 
 );
 print('CustomHttpClient: Received response with status ${httpResponse.statusCode}');
 if(httpResponse.statusCode==440 && !_hasTriggeredLogout){
 print('CustomHttpClient: Detected 440, adding LogoutEvent to AuthBloc[${authBloc.id}]');
      _hasTriggeredLogout = true;
  authBloc.add(LogoutEvent());
  
  throw Exception('Session time out');

 }
 return http.StreamedResponse(Stream.value(responseBytes),httpResponse.statusCode,
  headers: httpResponse.headers,
  request: httpResponse.request,
  persistentConnection: httpResponse.persistentConnection,
  reasonPhrase: httpResponse.reasonPhrase
 );
  }
  @override
  void close(){
    _innerClient.close();
  }
}
