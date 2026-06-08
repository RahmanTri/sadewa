import 'dart:convert';

import 'package:get/get.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/models/notice_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:intl/intl.dart';

class NoticeController extends GetxController {
  final ApiService _apiService = ApiService();
  final UserController _userController = Get.find<UserController>();

  final filteroptions = ['Terbaru', 'Belum Dibaca', 'Sudah Dibaca', 'Semua'].obs;

  var selectedFilter = 'Terbaru'.obs;
  var notices = <Notice>[].obs;
  var filteredNotices = <Notice>[].obs;

  var beingRead = Rxn<Notice>();

  var theresUnreadNotice = false.obs;
  var noticesNotRead = 0.obs;
  

  var isLoading = true.obs;
  var dummyNoticesInject = false;


  Future<void> fetchNotices() async {
    isLoading.value = true;
    final String authtoken = _userController.userToken.value;

    notices.clear();

    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: AppUrls.notice,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat pesan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authtoken'},
      );
      final jsonData = result['data'];
      final data = jsonData
          .map((item) => Notice.fromJson(item))
          .toList();
      for (int i = 0; i < data.length; i++) {
        Notice addedNotice = data[i];
        addedNotice.trimContent();
        notices.add(addedNotice);
      }
      
      checkUnreadNotices();
      applyFilter(selectedFilter.value);

      isLoading.value = false;
      return;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
      return;
    }
  }

  Future<void> noticesHasBeenRead() async {
    final String authtoken = _userController.userToken.value;
    final endpoint = AppUrls.noticeRead;
    final data = {'id': beingRead.value!.id};

    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat pesan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authtoken'},
        data: data,
      );
      if (result['success'] == true) {
        checkUnreadNotices();
      }
      return;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    }
  }

  void checkUnreadNotices() {
    int count = 0;
    for (int i = 0; i < notices.length; i++) {
      if (notices[i].isRead == false) {
        count += 1;
        noticesNotRead.value = count;
        theresUnreadNotice.value = true;
      }
    }
    if (count == 0) {
      theresUnreadNotice.value = false;
      noticesNotRead.value = 0;
    }
  }

   void applyFilter(String filter) {
    isLoading.value = true;
    selectedFilter.value = filter;
    generateNoticesDesc();

    if (filter == 'Semua') {
      filteredNotices.assignAll(notices);
      isLoading.value = false;
    } else if (filter == 'Belum Dibaca') {
      filteredNotices.assignAll(
        notices.where((notice) => notice.isRead == false),
      );
      isLoading.value = false;
    } else if (filter == 'Sudah Dibaca') {
      filteredNotices.assignAll(
        notices.where((notice) => notice.isRead == true),
      );
      isLoading.value = false;
    } else {
      filteredNotices.assignAll(
        notices.where((notice) {
          final noticeDate = DateFormat('yyyy-MM-dd').parse(notice.date);
          final today = DateTime.now();
          return noticeDate.isAfter(today.add(Duration(days: -7))) && notice.isRead == false;
        }), 
      );
      isLoading.value = false;
    }
  }

  void readNotice(Notice notice) {
    isLoading.value = true;
    beingRead.value = notice;
    isLoading.value = false;
  }

  void hasBeenRead() {
    isLoading.value = true;
    notices.where((e) => e.id == beingRead.value!.id).first.isRead = true;
    applyFilter(selectedFilter.value);
    isLoading.value = false;
  }

  void generateNoticesDesc() {
    isLoading.value = true;
    if (notices.isNotEmpty) {
      for (int i = 0; i < notices.length; i++) {
        notices[i].trimContent();
        notices[i].isDescCreated = true;
      }
    }
    isLoading.value = false;
  }

  void dummyNotices() {
    isLoading.value = true;

    if (!dummyNoticesInject) {

      notices.clear();

      Notice noticemsg1 = Notice(
        id: 1,
        title: 'Peringatan Poin Rendah',
        content: 'Anda memiliki poin yang rendah. Anda tidak dapat lagi menikmati benefit bonus mingguan dan bulanan serta tambahan uang lembur. tingkatkan lagi kedisiplinan anda dalam bekerja agar anda dapat kembali meikmati benefit tersebut.',
        date: '2026-04-21',
        isRead: false
      );
      
      Notice noticemsg2 = Notice(
        id: 2,
        title: 'Peringatan Poin Rendah',
        content: 'Anda memiliki poin yang rendah. Anda tidak dapat lagi menikmati benefit bonus mingguan dan bulanan serta tambahan uang lembur. tingkatkan lagi kedisiplinan anda dalam bekerja agar anda dapat kembali meikmati benefit tersebut.',
        date: '2026-04-20',
        isRead: false
      );

      Notice noticemsg3 = Notice(
        id: 3,
        title: 'Peringatan Poin Rendah',
        content: 'Anda memiliki poin yang rendah. Anda tidak dapat lagi menikmati benefit bonus mingguan dan bulanan serta tambahan uang lembur. tingkatkan lagi kedisiplinan anda dalam bekerja agar anda dapat kembali meikmati benefit tersebut.',
        date: '2026-04-11',
        isRead: false
      );

      Notice noticemsg4 = Notice(
        id: 4,
        title: 'Peringatan Poin Rendah',
        content: 'Anda memiliki poin yang rendah. Anda tidak dapat lagi menikmati benefit bonus mingguan dan bulanan serta tambahan uang lembur. tingkatkan lagi kedisiplinan anda dalam bekerja agar anda dapat kembali meikmati benefit tersebut.',
        date: '2026-04-19',
        isRead: false
      );

      Notice noticemsg5 = Notice(
        id: 5,
        title: 'Peringatan Poin Rendah Test',
        content: 'Tests Anda memiliki poin yang rendah. Anda tidak dapat lagi menikmati benefit bonus mingguan dan bulanan serta tambahan uang lembur. tingkatkan lagi kedisiplinan anda dalam bekerja agar anda dapat kembali meikmati benefit tersebut.',
        date: '2026-04-19',
        isRead: false
      );

      notices.add(noticemsg1);
      notices.add(noticemsg2);
      notices.add(noticemsg3);
      notices.add(noticemsg4);
      notices.add(noticemsg5);
      dummyNoticesInject = true;
      applyFilter(selectedFilter.value);
    }

    applyFilter(selectedFilter.value);

      isLoading.value = false;
  }
}