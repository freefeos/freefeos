part of '../../manager.dart';

abstract interface class IDetailsViewModule {
  String? formattDateString(DateTime? dateTime);
}

class DetailsViewModule with ViewModel implements IDetailsViewModule {
  DetailsViewModule();

  @override
  String? formattDateString(DateTime? dateTime) {
    if (dateTime == null) return null;
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');
    return '$year/$month/$day $hour:$minute:$second';
  }
}
