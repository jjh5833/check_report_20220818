import 'dart:convert';

enum DisorderFlag {N, Y}
enum SignatureExistFlag {N, Y}

class PMData{
  String pmTitle = '';
  String companyName = '';
  String jobDate = '';
  String jobManager = '';
  int maxWorkerNum = 9;
  String workPlace = '';
  int workerNum = 0;
  List<pmWorker> workers = [];
  String signFileName = '';
  bool signExist = false;

  Map<String, dynamic> toJson() {
    return {
      'construction_name' : pmTitle,
      'company_name' : companyName,
      'job_date' : jobDate,
      'job_manager' : jobManager,
      'work_place' : workPlace,
      'worker_num' : workerNum,
      'sign_yn' : signExist,
      'sign_file_name' : signFileName,
      'workers' : jsonEncode(workers),
    };
  }
}

class pmWorker {
  late int seq;
  late String workerName;
  late String jobDescription;
  late String disorderYN;
  late String disorderDescription;
  late String signYN;
  late String singFileInfo;

  Map<String, dynamic> toJson() {
    return {
      'seq': seq,
      'worker_name' : workerName,
      'job_description' : jobDescription,
      'disorder_yn' : disorderYN,
      'disorder_description' : disorderDescription,
      'sign_yn' : signYN,
      'sign_file_name' : singFileInfo,
    };
  }
}