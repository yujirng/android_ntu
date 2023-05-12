List<String> loaiMHs = ["Điện thoại", "Laptop", "TV", "Tủ lạnh"];

class MatHang {
  String? name, loaiMH;
  int? soLuong;         // để có thể là null ({});

  MatHang({this.name, this.loaiMH, this.soLuong}); // thường thì phải đặt require cho trường nào đó để đảm bảo đủ dữ liệu

}