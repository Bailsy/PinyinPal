import 'package:pinyinpal/models/profilemodel.dart';
import 'package:pinyinpal/pages/collection/collection_page.dart';
import 'package:pinyinpal/services/json_downloader.dart';

class HskPath {
  static String hsklvl = 'hsk1';
  static String hskPath = 'assets/json/$hsklvl.json';

  static Future loadData() async {
    HskPath.hskPath = 'assets/json/$hsklvl.json';
    print(HskPath.hskPath);
    DownloadJson js = DownloadJson();
    ProfileModel currentProfile = ProfileModelSingleton().profileModel;
    await js.downloadJson(hsklvl, currentProfile.userId.toString());
  }
}
