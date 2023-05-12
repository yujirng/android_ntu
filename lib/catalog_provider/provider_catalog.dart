import 'package:flutter/foundation.dart';

class MatHang {
  String tenMH;
  int gia;
  MatHang({
    required this.tenMH, // name parameter
    required this.gia,
  });
}

class CatalogN5 extends ChangeNotifier{
  List<MatHang> _matHang = [
    MatHang(tenMH: "Xoài", gia: 45000),
    MatHang(tenMH: "Táo", gia: 10000),
    MatHang(tenMH: "Chuối", gia: 20000),
    MatHang(tenMH: "Bầu", gia: 20000),
    MatHang(tenMH: "Bí", gia: 30000),
    MatHang(tenMH: "Nho", gia: 78000),
    MatHang(tenMH: "Dưa leo", gia: 70000),
    MatHang(tenMH: "Dưa hấu", gia: 20000),
    MatHang(tenMH: "Cam", gia: 40000),
    MatHang(tenMH: "Ớt", gia: 23000),
    MatHang(tenMH: "Ổi", gia: 27000),
    MatHang(tenMH: "Thanh Long", gia: 28000),
    MatHang(tenMH: "Cam", gia: 13000),
    MatHang(tenMH: "Dâu tây", gia: 23000),
    MatHang(tenMH: "Mận", gia: 42000),
    MatHang(tenMH: "Mận Mỹ", gia: 32000),
    MatHang(tenMH: "Nho Mỹ", gia: 12000),
  ];
  List<int> _gioHang = []; // lưu index của pt trong giỏ hàng -> nên là list int

  List<MatHang> get matHangs => _matHang;
  List<int> get gioHang => _gioHang;

  int get soLuongMatHang => _matHang.length;
  int get soLuongGioHang => _gioHang.length;
  int get tienMuaHang => _gioHang.fold(0, (previousValue, element) => previousValue + _matHang[element].gia);

  int get tienThanhToan {
    int tong = 0;
    for (int i = 0; i < gioHang.length; i++){
      tong += matHangs[gioHang[i]].gia;
    }
    return tong;
  }

  void themVaoGioHang(int index) {
    _gioHang.add(index);
    notifyListeners();
  }

  void xoaKhoiGioHang(int index) {
    _gioHang.removeAt(index);
    notifyListeners();
  }

  bool kiemTraMHTonTaiTrongGH(int index){
    for (int i in _gioHang)
      if (i == index)
        return true;
      return false;
  }
}




