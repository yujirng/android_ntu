class SinhVien {
  String id, ten;
  String? ngaySinh, queQuan;

  SinhVien({required this.id, required this.ten, this.ngaySinh, this.queQuan});

  @override
  String toString() {
    return 'id: $id\n ten: $ten\n ngaySinh: $ngaySinh\n queQuan: $queQuan\n';
  }
}

class QLSV {
  final List<SinhVien> _list = [];
  // properties
  List<SinhVien> get ds => _list; //lay sinh vien qua danh sach

  void add(SinhVien sv){
    /*for(var sv in _list){
      if(sv.id == sv.id){
        return;
      }
    }*/
    _list.add(sv);
  }

  void update(SinhVien newSV){
    for(var s in _list){
      if(s.id == newSV.id){
        s.ten = newSV.ten;
        s.queQuan = newSV.queQuan;
        s.ngaySinh = newSV.ngaySinh;
        return;
      }
    }
  }

  void delete(String id){
    for(var s in _list){
      if(s.id == id){
        _list.remove(s);
        return;
      }
    }
  }

  void printInfo() {
    for(var s in _list){
      print(s.toString());
    }
  }
}

void main() {
  QLSV ql = QLSV();
  ql.add(SinhVien(id: '1', ten: 'Dung'));
  ql.add(SinhVien(id: '2', ten: 'Anh'));
  ql.add(SinhVien(id: '3', ten: 'Thien'));
  ql.add(SinhVien(id: '4', ten: 'AAA'));
  ql.add(SinhVien(id: '5', ten: 'BBB'));
  ql.add(SinhVien(id: '6', ten: 'CCC'));
  ql.printInfo();
  ql.delete('1');
  print("Sau khi xoa:");
  ql.printInfo();
}