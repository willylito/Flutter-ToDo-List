import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'internet_check_state.dart';

class InternetCheckCubit extends Cubit<InternetCheck> {
  InternetCheckCubit()
      : super(const InternetCheck(ConnectivityStatus.connected));

  late StreamSubscription<List<ConnectivityResult>> subscription;

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    updateConnectivityStatus(connectivityResult.first);
  }

  void updateConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(const InternetCheck(ConnectivityStatus.disconnected));
    } else {
      emit(const InternetCheck(ConnectivityStatus.connected));
    }
  }

  void trackConnectivityChange() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((result) => updateConnectivityStatus(result.first));
  }

  void dispose() {
    subscription.cancel();
  }
}
