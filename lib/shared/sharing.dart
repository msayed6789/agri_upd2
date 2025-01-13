

class DataStored {
  String hisNum;
  String faNum;
  String moNum;
  String spec;
  String gender;
  String fireSaveNum = "";
  DateTime birthday;
  List weights = [];
  List weightsTime=[] ;
  bool timeForWeight=false;
  DataStored({
    required this.hisNum,
    required this.faNum,
    required this.moNum,
    required this.spec,
    required this.gender,
    required this.birthday,
  });
}

List<DataStored> allData = [];