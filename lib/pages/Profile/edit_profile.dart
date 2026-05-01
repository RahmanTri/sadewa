import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/pages/Profile/widget/edit_profile.dart';

class EditProfile extends StatelessWidget{
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: 60,
        title: Text(
          'Edit Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back, 
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:SDWcolors.primary,
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Obx (() => Stack(
                      children: [
                        CircleAvatar(
                          radius: 63.5,
                          backgroundColor: SDWcolors.bgL,
                          child: CircleAvatar(
                            radius: 60,
                          //   backgroundImage: userController.selectedImagePath.value != ''
                          //     ? FileImage(File(userController.selectedImagePath.value)) as ImageProvider  
                          //     : NetworkImage(userController.user.value!.fotoProfil),
                           ),
                        ),
                    //     Positioned(
                    //       bottom: 0,
                    //       right: 0,
                    //       child: GestureDetector(
                    //         // onTap: () => _showPicker(context),
                    //         //  child: Container(
                    //         //   padding: const EdgeInsets.all(8),
                    //         //   decoration: BoxDecoration(
                    //         //     color: SDWcolors.bgL,
                    //         //     shape: BoxShape.circle, 
                    //           ),
                    //           child: Icon(
                    //             Icons.camera_alt,
                    //             color: SDWcolors.primary,
                    //             size: 21,
                    //           ),
                    //         ),
                    //       ),
                    //     ),     
                       ],
                    )),
                
            
                //     void _showPicker(BuildContext context) {
                //       Get.bottomSheet(
                //         Container(
                //           backgroundColor: SDWcolors.bgL,
                //           padding: const EdgeInsets.all(20),
                //           shape: const RoundedRectangleBorder(
                //             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                //           ),
                //           child: Wrap(
                //             children: [
                //               ListTile(
                //                 leading: const Icon(Icons.camera_alt),
                //                 title: const Text('Camera'),
                //                 onTap: () {
                //                   userController.getImage(ImageSource.camera);
                //                   Get.back();
                //                 },
                //               )
                //             ],
                //           ),
                //         )
                //       );
                //     }
                   ),
                 ),
            
            Positioned(
              top: 170,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,   
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(33),
                    topRight: Radius.circular(33),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Obx(() => Column(            
                    children: [
                      editProfile(
                        icon: Icons.person, 
                        title: 'Nama',
                        value: userController.user.value!.namaLengkap,
                        controller: userController.nameController,
                      ),                                  
                      editProfile(
                        icon: Icons.email, 
                        title: 'Email',
                        value: userController.user.value!.email, 
                        controller: userController.emailController,
                      ),                                  
                      editProfile(
                        icon: Icons.phone, 
                        title: 'Nomor Telepon',
                        value: userController.user.value!.noTelp,
                        controller: userController.phoneController,
                      ),                                  
                      editProfile(
                        icon: Icons.games_rounded, 
                        title: 'Divisi',
                        value: userController.user.value!.namaDivisi,
                        controller: userController.divisionController,
                      ),
                      const SizedBox(height: 30),
                      Obx(()  {
                        bool editing = userController.isEditing.value;

                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: editing ? SDWcolors.primary : SDWcolors.primary,
                            ),
                            onPressed: () {
                              if (editing) {
                                userController.updateUser();
                                userController.toogleEdit();
                              } else {
                                userController.toogleEdit();
                              }
                            },
                            child: Text(
                              editing ? 'SIMPAN' : 'UBAH',
                              style: const TextStyle(
                                fontSize: 18, 
                                color: SDWcolors.textL, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        );
                      }),                                  
                    ],
                  ),
                ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}