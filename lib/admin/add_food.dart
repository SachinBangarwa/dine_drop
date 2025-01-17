import 'dart:io';
import 'package:dine_drop/admin/service/upload_item_cloud_service.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  List<String> categoryList = ['ice-cream', 'food', 'burger', 'fruit'];
  String selectValue = 'fruit';
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? path;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _detailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
        title: Text(
          'Add Food',
          style: AppSupportWidget.boldTextStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload the item Pitcher',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                SizedBox(
                  height: Get.height / 35,
                ),
                path == null
                    ? GestureDetector(
                        onTap: () async {
                          await _onTabGetImage();
                        },
                        child: Align(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(color: Colors.grey, blurRadius: 4)
                                ],
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : Align(
                        child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(color: Colors.grey, blurRadius: 4)
                                ],
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(
                                  path!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                SizedBox(
                  height: Get.height / 35,
                ),
                const Text(
                  'Item Name',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                  height: Get.height / 16,
                  decoration: BoxDecoration(
                      color: const Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: const TextStyle(
                        fontFamily: 'Poppins', color: Colors.black54),
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Item Name',
                        hintStyle: AppSupportWidget.lightBoldTextStyle()),
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                const Text(
                  'Item Price',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                  height: Get.height / 16,
                  decoration: BoxDecoration(
                      color: const Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: const TextStyle(
                        fontFamily: 'Poppins', color: Colors.black54),
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Item Price',
                        hintStyle: AppSupportWidget.lightBoldTextStyle()),
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                const Text(
                  'Item Detail',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    controller: _detailController,
                    style: const TextStyle(
                        fontFamily: 'Poppins', color: Colors.black54),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Item Detail';
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Item Detail',
                        hintStyle: AppSupportWidget.lightBoldTextStyle()),
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                const Text(
                  'Select Category',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectValue,
                        items: categoryList
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black54),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          selectValue = value ?? 'ice-crime';
                          setState(() {});
                        },
                        hint: const Text('Select Category'),
                        iconSize: 36,
                        icon: const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.black,
                        ),
                      ),
                    )),
                SizedBox(
                  height: Get.height / 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await onTabUploadItemCloud();
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                      child: Text(
                        'Add',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future onTabUploadItemCloud() async {
    final name = _nameController.text.trim();
    final price = _priceController.text.trim();
    final detail = _detailController.text.trim();
    if (path != null &&
        name.isNotEmpty &&
        price.isNotEmpty &&
        detail.isNotEmpty &&
        selectValue.isNotEmpty) {
      String addId = randomAlphaNumeric(10);
      Reference reference =
          FirebaseStorage.instance.ref().child('blogImage').child(addId);
      UploadTask uploadTask = reference.putFile(File(path!));
      //  String uploadImage = await (await uploadTask).ref.getDownloadURL();
      Map<String, dynamic> items = {
        'imageUrl': path,
        "itemName": name,
        "itemPrice": price,
        "itemDetail": detail
      };

      await UploadItemCloudService.uploadItem(items, selectValue);
      _nameController.clear();
      _priceController.clear();
      _detailController.clear();
    }
  }

  Future<void> _onTabGetImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        path = file.path;
      });
    }
  }
}
