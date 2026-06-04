import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/Profile/widget/contact_support.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadewa_fe/controllers/help_center_controller.dart';

class HelpCenter extends StatelessWidget {
  HelpCenter({super.key});

  final helpCenterController = Get.find<HelpCenterController>();  

Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    Get.snackbar('Error', 'Gagal membuka link');
  }
}

  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: SDWcolors.bgD,
        appBar: AppBar(
          backgroundColor: SDWcolors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(), 
            icon: const Icon(
              Icons.arrow_back, 
              color: SDWcolors.textD
            ),
          ),
          title: const Text(
            'Help Center', 
            style: TextStyle(
              color: SDWcolors.textD,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          bottom: const TabBar(
            indicatorColor: SDWcolors.primary,
            indicatorWeight: 2.5,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: SDWcolors.primary,
            unselectedLabelColor: SDWcolors.essentialL,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
            tabs: [
              Tab(text: 'FAQ'),
              Tab(text: 'Contact Support'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: TextField(
                    onChanged: (value) => helpCenterController.searchQuery.value = value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: SDWcolors.primary,
                      ),
                      hintText: 'Cari masalah Anda disini',
                      hintStyle: const TextStyle(
                        color: SDWcolors.grey,
                        fontSize: 14,
                      ),
                      fillColor: SDWcolors.bgL,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // Filter Kategori
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: helpCenterController.categories.length,
                    itemBuilder: (context, index) {
                      String categoryName = helpCenterController.categories[index];
                      return Obx(() {
                        bool isSelected = helpCenterController.selectedCategory.value == categoryName;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          child: InkWell(
                            onTap: () => helpCenterController.selectedCategory.value = categoryName,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 28),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? SDWcolors.primary : SDWcolors.bgL, 
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? SDWcolors.bgL : SDWcolors.essentialL,
                                  width: 1.2,
                                ), 
                              ),
                              child: Text(
                                categoryName,
                                style: TextStyle(
                                  color: isSelected ? SDWcolors.textL : SDWcolors.textD,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),

                Expanded(
                  child: Obx(() {
                    var currentList = helpCenterController.filteredFaq;

                    if (currentList.isEmpty) {
                      return const Center(
                        child: Text(
                          'No results found',
                          style: TextStyle(
                            color: SDWcolors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        )
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: SDWcolors.bgL,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: SDWcolors.essentialL,
                              width: 1.2
                            )
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: SDWcolors.transparent),
                            child: ExpansionTile(
                              iconColor: SDWcolors.primaryL,
                              collapsedIconColor: SDWcolors.primary,
                              title: Text(
                                currentList[index]['q']!,
                                style: const TextStyle(
                                  color: SDWcolors.textD,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 17, right: 17, bottom: 17),
                                  child: Text(
                                    currentList[index]['a']!,
                                    style: const TextStyle(
                                      color: SDWcolors.textD,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    )
                                  ),
                                ),
                              ],
                              ),
                          ),
                        );
                      }
                    );
                  }) 
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Butuh Bantuan Lebih Lanjut?',
                    style: TextStyle(
                      color: SDWcolors.textD,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 25),

                  contactCard(
                    icon: FontAwesomeIcons.whatsapp,
                    title: 'WhatsApp', 
                    color: SDWcolors.bgL, 
                    onTap: (){
                      String nomorWA = '6289515977063';
                      String pesan = 'Woy Admin, aplikasine error kocag';
                      _launchURL("https://wa.me/$nomorWA?text=${Uri.encodeComponent(pesan)}");
                    },
                  ),
                  const SizedBox(height: 15),
                  contactCard(
                    icon: FontAwesomeIcons.envelope, 
                    title: 'Email', 
                    color: SDWcolors.bgL, 
                    onTap: () => _launchURL('mailto:sadewadev.official@gmail.com'),
                  ),
                ],
              ),
            ),
          ]
          ),
      ),      
    );
  }
}