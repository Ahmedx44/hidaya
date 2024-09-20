class TimeUsecase {
  getCurrentTIme() {
    final DateTime now = DateTime.now();
    final String formattedTime = '${now.hour}:${now.minute}:${now.second}';

    return formattedTime;
  }
}
