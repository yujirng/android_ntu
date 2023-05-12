import 'package:get/get.dart';

class MatHang {
  String tenMH;
  int gia;
  MatHang({
    required this.tenMH, // name parameter
    required this.gia,
  });
}

class CatalogN5 extends GetxController{
  final RxList<MatHang> _matHang = <MatHang>[
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
  ].obs;
  final RxList<int> _gioHang = <int>[].obs; // lưu index của pt trong giỏ hàng -> nên là list int

  List<MatHang> get matHangs => _matHang.value;
  List<int> get gioHang => _gioHang.value;

  int get soLuongMatHang => _matHang.value.length;
  int get soLuongGioHang => _gioHang.value.length;
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
    _gioHang.refresh();
    // Rx Type trên kiểu dữ liệu không phải primitive thì cần phải gọi refresh thì giao diện mới cập nhật
    _matHang.refresh();
  }

  void xoaKhoiGioHang(int index) {
    _gioHang.removeAt(index);
    _gioHang.refresh();
    // Rx Type trên kiểu dữ liệu không phải primitive thì cần phải gọi refresh thì giao diện mới cập nhật
    _matHang.refresh();
  }

  bool kiemTraMHTonTaiTrongGH(int index){
    for (int i in _gioHang)
      if (i == index)
        return true;
      return false;
  }



}




