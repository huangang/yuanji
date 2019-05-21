import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


String dateFormatted() {
  initializeDateFormatting();
  var now = DateTime.now();

  var formatter = new DateFormat("EEE, yyyy/MM/dd HH:mm:ss", "zh_CN");
  String formatted = formatter.format(now);

  return formatted;


}