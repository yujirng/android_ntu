import 'package:android_ntu/firebase/cloud_firestore/firebase_data.dart';
import 'package:android_ntu/firebase/cloud_firestore/page_firebase_detail.dart';
import 'package:android_ntu/firebase/widget_connect_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:android_ntu/helper/dialogs.dart';

class MyFirebaseApp extends StatelessWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageSVs(),
        errorMessage: "Lỗi",
        connectingMessage: "Đang kết nối...");
  }
}

class PageSVs extends StatefulWidget {
  const PageSVs({Key? key}) : super(key: key);

  @override
  State<PageSVs> createState() => _PageSVsState();
}

class _PageSVsState extends State<PageSVs> {
  BuildContext? _dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách SV"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageInformation(xem: false),
                  )),
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ))
        ],
      ),
      // hiển thị stream, khi từ 2 stream trở lên thì sẽ có phương thức khác
      body: FutureBuilder<List<SinhVienSnapshot>>(
        // bỏ stream đi thì <ghi trong>
        future: SinhVienSnapshot.dsSVTuFirebaseOneTime(),
        builder: (context, snapshot) {
          // print(snapshot);
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                    "Lỗi", // widget để truy xuất lên trên
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    textDirection:
                        TextDirection.ltr // không viết trong scaffold
                    ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                        "Đang load data"
                        ,// widget để truy xuất lên trên
                        style: TextStyle(fontSize: 16),
                        textDirection:
                            TextDirection.ltr // không viết trong scaffold
                        ),
                  ]),
            );
          } else {
            var list = snapshot.data!;
            return ListView.separated(
                itemBuilder: (context, index) {
                  _dialogContext = context;
                  return Slidable(
                  child: ListTile(
                        leading: Text("${index + 1}", style: TextStyle(color: Colors.black, fontSize: 20)),
                        title: Text("${list[index].sinhVien!.ten}", style: TextStyle(color: Colors.blueAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text("${list[index].sinhVien!.lop}", style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(), children: [
                      SlidableAction(
                          onPressed: (context) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PageInformation(svs: list[index], xem: true))
                            );
                          },
                        label: "Xem",
                        icon: Icons.remove_red_eye,
                        foregroundColor: Colors.green,
                      ),
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PageInformation(svs: list[index], xem: false),)
                        );
                      },
                      label: "Edit",
                      icon: Icons.edit,
                      foregroundColor: Colors.blue,
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        _xoa(_dialogContext, list, index);
                      },
                      label: "Xóa",
                      icon: Icons.delete,
                      foregroundColor: Colors.red,
                    )
                    ],
                  ),
                );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: list.length
            );
          }
        },
      ),
    );
  }

  _xoa(BuildContext? dialogContext, List<SinhVienSnapshot> list, int index) async {
    String? confirm = await showConfirmDialog(dialogContext!, "Bạn có muốn xóa ${list[index].sinhVien!.ten}");
    if(confirm == "ok"){
      await list[index].delete();
      showSnackBar(dialogContext!, "Đã xóa!", 1000);
    }
  }
}
