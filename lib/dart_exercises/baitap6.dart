import 'dart:io';

void tinhNam(String ten, int namSinh) {
  final getYearNow = DateTime.now().year;
  int tuoi = getYearNow - namSinh;
  print("Tên của bạn là: $ten");
  print("Bạn phải sống: ${100 - tuoi} năm nữa để được 100 tuổi");
}

List<int> soDu(List<int> li) {
  return li.map((element) => (element % 5)).toList();
}

List listDuplicate (List list1, List list2) {
  return list1.where((element) => list2.contains(element)).toList();
}

void main() {
  tinhNam("Nguyễn Văn A", 2002);

  List<int> li = [6,9,11,12,15,17,20];
  List<int> li2 = [1,1,6,1,1,1];

  List<int> listSoDu = soDu(li);
  listSoDu.forEach((element) {stdout.write("$element ");});

  print("");
  List listTrung = listDuplicate(li, li2);
  print(listTrung);
}