import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/notice_controller.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/User/Notice/widgets/notice_card.dart';
import '../../effect/box_shadow.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noticeController = Get.find<NoticeController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Future.microtask(() => noticeController.dummyNotices());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: height * 0.05,
        title: Text(
          'Peringatan',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        children: [
          Container(
            height: height * 0.04,
            decoration: const BoxDecoration(
              color: SDWcolors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.064),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    height: 32,
                    width: width * 0.42,
                    decoration: BoxDecoration(
                      color: SDWcolors.bgL,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [SDWboxShadow.shadow],
                    ),
                    child: Center(
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isDense: true,
                                dropdownColor: SDWcolors.bgL,
                                menuWidth: width * 0.42,
                                value: noticeController.selectedFilter.value,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                icon: Transform.rotate(
                                  angle: 3.14 / -2,
                                  child: Icon(
                                    Icons.chevron_left_outlined,
                                    color: SDWcolors.primary,
                                    size: 24,
                                  ),
                                ),
                                items: noticeController.filteroptions.map((
                                  filter,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: filter,
                                    child: Text(filter),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    noticeController.selectedFilter.value =
                                        newValue;
                                    noticeController.applyFilter(newValue);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Obx(
                () => noticeController.isLoading.value
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: SDWcolors.primary),
                            SizedBox(height: 10),
                            Text(
                              'Memuat Data...',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : Obx(
                        () => noticeController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: SDWcolors.primary,
                                ),
                              )
                            : noticeController.filteredNotices.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/blank-page-img.png',
                                      ),
                                      height: height * 0.5,
                                      width: width * 0.4,
                                    ),
                                    Text(
                                      'Anda belum memiliki pesan',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  physics: BouncingScrollPhysics(),
                                  itemCount:
                                      noticeController.filteredNotices.length,
                                  itemBuilder: (context, index) => NoticeCard(
                                    height: height,
                                    width: width,
                                    gap: 12,
                                    notice:
                                        noticeController.filteredNotices[index],
                                  ),
                                ),
                              ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
