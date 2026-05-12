import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/akun_controller.dart';
import 'package:sadewa_fe/pages/Admin_ManajerAkun/widgets/akun_card.dart';
import 'package:sadewa_fe/pages/Admin_ManajerAkun/widgets/popup_add.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

class ManajerAkun extends StatefulWidget {
  const ManajerAkun({super.key});

  @override
  State<ManajerAkun> createState() => _ManajerAkunState();
}

class _ManajerAkunState extends State<ManajerAkun> {
  late AkunController akunController;

  @override
  void initState() {
    akunController = Get.find<AkunController>();
    akunController.fetchAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.find<AkunController>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: height * 0.05,
        title: Text(
          'Manajer Akun',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          akunController.clearError(),
          akunController.addNewAccount(),
          PopUpAdd.show(
            context: context,
            akunController: akunController,
            height: height,
            width: width,
          ),
        },
        backgroundColor: SDWcolors.primary,
        tooltip: 'Tambah Akun',
        child: Icon(Icons.add, color: SDWcolors.white),
      ),
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
              SizedBox(height: height * 0.054),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: width * 0.04),
                    padding: EdgeInsets.only(left: 8, right: 8),
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
                                isExpanded: true,
                                isDense: true,
                                dropdownColor: SDWcolors.bgL,
                                menuWidth: width * 0.42,
                                value: akunController.selectedFilter.value,
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
                                items: akunController.filterOptions.map((
                                  filter,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: filter,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Text(filter),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    akunController.selectedFilter.value =
                                        newValue;
                                    akunController.applyFilter(newValue);
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
              SizedBox(height: height * 0.012),

              //Test Only
              // Obx(
              //   () => GestureDetector(
              //     // onTap: () => {akunController.clearList()},
              //     child: Container(
              //       width: width * 0.4,
              //       height: height * 0.028,
              //       decoration: BoxDecoration(
              //         color: SDWcolors.primary,
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Text(
              //         akunController.editedAccount.value?.username ?? '',
              //         textAlign: TextAlign.center,
              //         style: Theme.of(
              //           context,
              //         ).textTheme.bodyLarge?.copyWith(color: SDWcolors.white),
              //       ),
              //     ),
              //   ),
              // ),

              //Here
              Expanded(
                child: Obx(
                  () => akunController.isLoading.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: SDWcolors.primary),
                            Text(
                              'Memuat Data...',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: SDWcolors.primary),
                            ),
                          ],
                        )
                      : akunController.filteredAccounts.isEmpty
                      ? Column(
                          children: [
                            Image.asset(
                              '${AppUrls.imgAssets}blank-page-img.png',
                              height: height * 0.5,
                              width: width * 0.4,
                            ),
                            Text(
                              'Tidak ada data',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.024,
                                  ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                          ),
                          itemCount: akunController.filteredAccounts.length,
                          itemBuilder: (context, index) => AkunCard(
                            akun: akunController.filteredAccounts[index],
                            width: width,
                            height: height,
                            gap: height * 0.012,
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
