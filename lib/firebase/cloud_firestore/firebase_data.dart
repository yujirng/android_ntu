import 'package:cloud_firestore/cloud_firestore.dart';

class SinhVien {
  String? anh, id, lop, nam_sinh, que_quan, ten;

  SinhVien(
      {this.anh,
      required this.id,
      this.lop,
      this.nam_sinh,
      this.que_quan,
      required this.ten});

  // chỉ xử lý đúng với firebase
  Map<String, dynamic> toJson() {
    return {
      'anh': this.anh,
      'id': this.id,
      'lop': this.lop,
      'nam_sinh': this.nam_sinh,
      'que_quan': this.que_quan,
      'ten': this.ten,
    };
  }

  factory SinhVien.fromJson(Map<String, dynamic> map) {
    return SinhVien(
      anh: map['anh'] as String,
      id: map['id'] as String,
      lop: map['lop'] as String,
      nam_sinh: map['nam_sinh'] as String,
      que_quan: map['que_quan'] as String,
      ten: map['ten'] as String,
    );
  }
}

// khi truy vấn dữ liệu, trả về querySnapshot, querySnapshot chứa documentSnapshot, documentSnapshot chứa reference

class SinhVienSnapshot {
  SinhVien? sinhVien;
  DocumentReference? documentReference;

  SinhVienSnapshot({
    required this.sinhVien,
    required this.documentReference,
  });

  factory SinhVienSnapshot.fromSnapshot(DocumentSnapshot docSVsnapshot) {
    return SinhVienSnapshot(
        sinhVien:
            SinhVien.fromJson(docSVsnapshot.data() as Map<String, dynamic>),
        documentReference: docSVsnapshot.reference);
  }

  Future<void> update(SinhVien sv) async {
    return documentReference!.update(sv.toJson());
  }

  Future<void> delete() async {
    return documentReference!.delete();
  }

  // để dễ quản lý
  static Future<DocumentReference?> themSV(SinhVien sv) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('SinhVien')
          .where('id', isEqualTo: sv.id)
          .get();
      if (sv.anh == null){
        throw Exception('Chưa có ảnh');
      }
      if (snapshot.docs.isNotEmpty) {
        throw Exception('ID bị trùng lặp, không thể thêm SinhVien');
      } else {
        // ID không bị trùng lặp, thêm SinhVien vào Firestore.
        return FirebaseFirestore.instance.collection('SinhVien').add(sv.toJson());
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  // đặt tên để gọi qua cái tên lớp
  static Stream<List<SinhVienSnapshot>> dsSVTuFilebase() {
    Stream<QuerySnapshot> streamQuery =
        FirebaseFirestore.instance.collection("SinhVien").snapshots();
    Stream<List<DocumentSnapshot>> stramListDocSnap = streamQuery
        .map((querySn) => querySn.docs); // => docs = list DocumentSnapshot
    //map 1: Chuyển Stream<List> --> Stream<List<DocumentSnapshot>>
    //map 2: Chuyển List<DocumentSnapshot> -> List<SinhVienSnapshot>
    return stramListDocSnap.map((listDocSnap) => listDocSnap
        .map((docSnap) => SinhVienSnapshot.fromSnapshot(docSnap))
        .toList()); // map trả về list gọi toList()
  }
  // map là một phương thức bình cũ, rượu mới
  // truy vấn dữ liệu, ép kiểu data về đối tượng

  static Future<List<SinhVienSnapshot>> dsSVTuFirebaseOneTime() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("SinhVien").get();
    return qs.docs.map((docSnap) => SinhVienSnapshot.fromSnapshot(docSnap)).toList();
  }
}

// cập nhật vào firebase
