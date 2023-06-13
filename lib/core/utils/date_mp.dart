String todaysDateDDYYMM(){
  var dateTimeObj = DateTime.now();

  String year = dateTimeObj.year.toString();

  String month = dateTimeObj.month.toString();
  if(month.length == 1){
    month = '0$month';
  }

  String day = dateTimeObj.day.toString();
  if(day.length == 1){
    day = '0$day';
  }

  String ddmmyyyy = day + month + year;

  return ddmmyyyy;

}

DateTime createDateTimeObj(String ddmmyyyy){
  int dd = int.parse(ddmmyyyy.substring(0,2));
  int mm = int.parse(ddmmyyyy.substring(2,4));
  int yyyy = int.parse(ddmmyyyy.substring(4,8));

  DateTime dateTimeObj = DateTime(yyyy,mm,dd);
  return dateTimeObj;


}


String convertDateTimeToDDMMYYYY(DateTime dateTime){


  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if(month.length == 1){
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if(day.length == 1){
    day = '0$day';
  }

  String ddmmyyyy = day + month + year;

  return ddmmyyyy;

}