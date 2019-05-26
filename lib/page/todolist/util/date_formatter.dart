import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


String dateFormatted(timestamp) {
  initializeDateFormatting();
  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat("EEE, yyyy/MM/dd HH:mm:ss", "zh_CN");
  String formatted = formatter.format(date);

  return formatted;


}