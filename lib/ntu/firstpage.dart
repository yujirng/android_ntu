import 'package:flutter/material.dart';
// import 'package:ntu_android/main.dart';

class PageFirst extends StatefulWidget {
  const PageFirst({Key? key}) : super(key: key);

  @override
  State<PageFirst> createState() => _PageFirstState();
}

class _PageFirstState extends State<PageFirst> {
  String loiChao = "Chào 62CNTT-2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loiChao, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ElevatedButton(onPressed: (){
              loiChao = loiChao == "Chào 62CNTT-2" ? "Hẹn gặp lại kỳ sau" : "Chào 62CNTT-2";
              //print(loiChao); // in trong console
              // phương thức setState(): báo cập nhật lại giao diện
              setState(() {
                // có thể để code bên trong
              });
            }, child: const Text("Click me!"))

          ],
        ),
      ),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // khởi tạo lại biến loiChao
    loiChao = "Hello 62CNTT2"; // khi thay đổi cái j phương thức build thì ta gọi hot reload
    // việc cài đặt lại ứng dụng khi ta thêm dữ liệu vào ứng dụng, ta thêm vào asset hoặc thay đổi thư viện hỗ trợ...
  }
}
