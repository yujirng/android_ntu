import 'package:cloud_firestore/cloud_firestore.dart';

class NongSan {
  String? anh, id, title, gia_goc, sao;
  int? gia;

  NongSan(
      {this.anh,
      required this.id,
      this.title,
      this.gia,
        this.gia_goc,
        this.sao,
  });

  // chỉ xử lý đúng với firebase
  Map<String, dynamic> toJson() {
    return {
      'anh': this.anh,
      'id': this.id,
      'title': this.title,
      'gia': this.gia,
      'giagoc': this.gia_goc,
      'sao': this.sao
    };
  }



  factory NongSan.fromJson(Map<String, dynamic> map) {
    return NongSan(
      anh: map['anh'] as String,
      id: map['id'] as String,
      title: map['title'] as String,
      gia: int.parse(map['gia'] as String),
      gia_goc: map['giagoc'] as String,
      sao: map['sao'] as String,
    );
  }
}

// khi truy vấn dữ liệu, trả về querySnapshot, querySnapshot chứa documentSnapshot, documentSnapshot chứa reference

class NongSanSnapshot {
  NongSan? nongSan;
  DocumentReference? documentReference;

  NongSanSnapshot({
    required this.nongSan,
    required this.documentReference,
  });

  factory NongSanSnapshot.fromSnapshot(DocumentSnapshot docSVsnapshot) {
    return NongSanSnapshot(
        nongSan:
            NongSan.fromJson(docSVsnapshot.data() as Map<String, dynamic>),
        documentReference: docSVsnapshot.reference);
  }

  Future<void> update(NongSan sv) async {
    return documentReference!.update(sv.toJson());
  }

  Future<void> delete() async {
    return documentReference!.delete();
  }

  // để dễ quản lý
  static Future<DocumentReference?> themSV(NongSan sv) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('NongSan')
          .where('id', isEqualTo: sv.id)
          .get();
      if (sv.anh == null){
        throw Exception('Chưa có ảnh');
      }
      if (snapshot.docs.isNotEmpty) {
        throw Exception('ID bị trùng lặp, không thể thêm NongSan');
      } else {
        // ID không bị trùng lặp, thêm NongSan vào Firestore.
        return FirebaseFirestore.instance.collection('NongSan').add(sv.toJson());
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  // đặt tên để gọi qua cái tên lớp
  static Stream<List<NongSanSnapshot>> dsSVTuFilebase() {
    Stream<QuerySnapshot> streamQuery =
        FirebaseFirestore.instance.collection("NongSan").snapshots();
    Stream<List<DocumentSnapshot>> stramListDocSnap = streamQuery
        .map((querySn) => querySn.docs); // => docs = list DocumentSnapshot
    //map 1: Chuyển Stream<List> --> Stream<List<DocumentSnapshot>>
    //map 2: Chuyển List<DocumentSnapshot> -> List<NongSanSnapshot>
    return stramListDocSnap.map((listDocSnap) => listDocSnap
        .map((docSnap) => NongSanSnapshot.fromSnapshot(docSnap))
        .toList()); // map trả về list gọi toList()
  }
  // map là một phương thức bình cũ, rượu mới
  // truy vấn dữ liệu, ép kiểu data về đối tượng

  static Future<List<NongSanSnapshot>> dsSVTuFirebaseOneTime() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("NongSan").get();
    return qs.docs.map((docSnap) => NongSanSnapshot.fromSnapshot(docSnap)).toList();
  }
}

// cập nhật vào firebase
