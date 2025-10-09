part of '../../manager.dart';

abstract interface class IDetailsViewModule {
  String? formattDateString(DateTime? dateTime);
}

class DetailsViewModule with ViewModel implements IDetailsViewModule {
  DetailsViewModule();

  @override
  String? formattDateString(DateTime? dateTime) {
    if (dateTime == null) return null;
    String y = dateTime.year.toString();
    String m = dateTime.month.toString().padLeft(2, '0');
    String d = dateTime.day.toString().padLeft(2, '0');
    String h = dateTime.hour.toString().padLeft(2, '0');
    String min = dateTime.minute.toString().padLeft(2, '0');
    String s = dateTime.second.toString().padLeft(2, '0');
    return '$y/$m/$d $h:$min:$s';
  }
}
