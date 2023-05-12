import 'dart:io';

import 'package:android_ntu/firebase/cloud_firestore/firebase_data.dart';
import 'package:android_ntu/helper/dialogs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageInformation extends StatefulWidget {
  bool? xem;
  SinhVienSnapshot? svs;
  PageInformation({Key? key, this.svs, required this.xem}) : super(key: key);

  @override
  State<PageInformation> createState() => _PageInformationState();
}

class _PageInformationState extends State<PageInformation> {
  SinhVienSnapshot? svs;

  bool _imageChange = false;
  XFile? _xImage;

  BuildContext? dialogContext;

  bool? xem;
  String title = "Thêm sinh viên mới";
  String buttonLabel = "Thêm";
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtLop = TextEditingController();
  TextEditingController txtNamSinh = TextEditingController();
  TextEditingController txtQueQuan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dialogContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông Tin SV"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  child: _imageChange
                      ? Image.file(File(_xImage!.path))
                      : svs?.sinhVien!.anh != null
                          ? Image.network(svs!.sinhVien!.anh!)
                          : null),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: xem != true ? () => _chonAnh(context) : null,
                      child: const Icon(Icons.image)),
                ],
              ),
              TextField(
                controller: txtId,
                decoration: const InputDecoration(
                  label: Text("Id: "),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: txtTen,
                decoration: const InputDecoration(
                  label: Text("Tên: "),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: txtLop,
                decoration: const InputDecoration(
                  label: Text("Lớp: "),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: txtNamSinh,
                decoration: const InputDecoration(
                  label: Text("Năm sinh: "),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: txtQueQuan,
                decoration: const InputDecoration(
                  label: Text("Quê quán: "),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (xem == true)
                          Navigator.pop(context);
                        else
                          _capNhat(context);
                      },
                      child: Text(buttonLabel)),
                  const SizedBox(width: 10),
                  xem == true
                      ? const SizedBox(width: 1)
                      : ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Đóng")),
                  const SizedBox(width: 10)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    xem = widget.xem;
    svs = widget.svs;

    if (svs != null) {
      txtId.text = svs!.sinhVien!.id ?? "";
      txtTen.text = svs!.sinhVien!.ten ?? "";
      txtLop.text = svs!.sinhVien!.lop ?? "";
      txtNamSinh.text = svs!.sinhVien!.nam_sinh ?? "";
      txtQueQuan.text = svs!.sinhVien!.que_quan ?? "";
      if (xem == true) {
        buttonLabel = "Đóng";
        title = "Thông tin sinh viên";
      } else {
        buttonLabel = "Cập nhật";
        title = "Cập nhật thông tin";
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    txtId.dispose();
    txtTen.dispose();
    txtLop.dispose();
    txtNamSinh.dispose();
    txtQueQuan.dispose();
  }

  _capNhat(BuildContext context) async {
    showSnackBar(context, "Đang cập nhật dữ liệu", 300);
    SinhVien sv = SinhVien(
      id: txtId.text,
      ten: txtTen.text,
      lop: txtLop.text,
      nam_sinh: txtNamSinh.text,
      que_quan: txtQueQuan.text,
      anh: null,
    );
    if (_imageChange) {
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference =
          _storage.ref().child("images").child("anh_${sv.id}.jpg");
      UploadTask uploadTask = await _uploadTask(reference, _xImage!);
      uploadTask.whenComplete(() async {
        sv.anh = await reference.getDownloadURL();
        if (svs != null) {
          _capNhatSV(svs, sv);
        } else {
          _themSV(sv);
        }
      }).onError((error, stackTrace) {
        return Future.error("Lỗi xảy ra");
      });
    } else if (svs != null) {
      sv.anh = svs!.sinhVien!.anh;
      _capNhatSV(svs, sv);
    } else
      _themSV(sv);
  }

  Future<UploadTask> _uploadTask(Reference reference, XFile xImage) async {
    final metaData = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': xImage.path});
    UploadTask uploadTask;
    if (kIsWeb)
      uploadTask = reference.putData(await xImage.readAsBytes(), metaData);
    else
      uploadTask = reference.putFile(File(xImage.path), metaData);
    return Future.value(uploadTask);
  }

  _chonAnh(BuildContext context) async {
    _xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_xImage != null) {
      setState(() {
        _imageChange = true;
      });
    }
  }

  _capNhatSV(SinhVienSnapshot? svs, SinhVien sv) {
    svs!
        .update(sv)
        .whenComplete(
            () => showSnackBar(context, "Cập nhật dữ liệu thành công!", 3))
        .onError((error, stackTrace) =>
            showSnackBar(context, "Cập nhật dữ liệu không thành công!", 3));
  }

  void _themSV(SinhVien sv) {
    SinhVienSnapshot.themSV(sv)
        .whenComplete(
            () {
              showSnackBar(context, "Thêm dữ liệu thành công!", 3);
            })
        .onError((error, stackTrace) {
      showSnackBar(context, error.toString().substring("Exception: ".length), 3);
      return Future.error("Lỗi khi thêm!");
    });
  }
}
