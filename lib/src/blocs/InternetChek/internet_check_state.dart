part of 'internet_check_cubit.dart';

enum ConnectivityStatus { connected, disconnected }

class InternetCheck {
  final ConnectivityStatus status;
  const InternetCheck(this.status);
}
