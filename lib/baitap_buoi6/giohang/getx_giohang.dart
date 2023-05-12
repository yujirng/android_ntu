import 'package:get/get.dart';

import '../firebase/firebase_data.dart';

class MatHang {
  String tenMH;
  int gia;
  MatHang({
    required this.tenMH, // name parameter
    required this.gia,
  });
}

class NongSanController extends GetxController{

  Stream<List<NongSanSnapshot>> nongSanStream = NongSanSnapshot.dsSVTuFilebase();

  List<NongSanSnapshot> listNongSan = [];

  void getListNongSan() async {
    await for (var data in nongSanStream) {
      listNongSan = data;
    }
  }

  final RxList<Map<String, int>> _gioHang = <Map<String, int>>[].obs; // lưu index của pt trong giỏ hàng -> nên là list int


  List<Map<String, int>> get gioHang => _gioHang.value;


  int get soLuongGioHang => _gioHang.value.length;
  int get tienMuaHang => _gioHang.fold(0, (previousValue, element) => previousValue + listNongSan[element['index']!].nongSan!.gia!);

  int get tienThanhToan {
    int tong = 0;
    // for (int i = 0; i < gioHang.length; i++){
    //   tong += listNongSan[gioHang[i]].nongSan!.gia!;
    // }

    for (var item in _gioHang){
      int index = item['index'] ?? 0;
      int soluong = item['soluong'] ?? 0;
      tong += listNongSan[index].nongSan!.gia! * soluong;
    }

    return tong;
  }

  void themVaoGioHang(int index) {
    bool existed = false;

    for (int i = 0; i < _gioHang.length; i++) {
      if (_gioHang[i]['index'] == index) {

        _gioHang[i]['soluong'] = (_gioHang[i]['soluong'] ?? 0) + 1;
        existed = true;
        break;
      }
    }

    if (!existed) {
      print(index);
      _gioHang.add({'index': index, 'soluong': 1});
    }
    _gioHang.refresh();
  }

  void xoaKhoiGioHang(int index) {
    _gioHang.removeAt(index);
    _gioHang.refresh();
  }

  void giamSoLuong(int index) {
    if (_gioHang[index]['soluong']! > 0)
      _gioHang[index]['soluong'] = (_gioHang[index]['soluong'] ?? 0) - 1;
    _gioHang.refresh();
  }


  void tangSoLuong(int index) {
    _gioHang[index]['soluong'] = (_gioHang[index]['soluong'] ?? 0) + 1;
    _gioHang.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getListNongSan();
  }



}




