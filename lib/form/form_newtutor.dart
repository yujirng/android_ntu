import 'package:flutter/material.dart';

class PageFormNewMatHang extends StatelessWidget {
  PageFormNewMatHang({Key? key}) : super(key: key);
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Form"),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            TextFormField(
              controller: txtName,
              decoration: InputDecoration(
                  labelText: "Tên Sản Phẩm",
                  hintText: "Hiện Tên Sản Phẩm Vào Đây"
              ),
              validator: (value) => validateString(value, message: "Tên sản phẩm chưa nhập"),
              onSaved: (newValue) => showSnackBar(context, message: "Sản phẩm $newValue đã được lưu"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {
                  if(formState.currentState?.validate() == true)
                    formState.currentState?.save();
                }, child: Text("Save"))
              ],
            )
          ],

        ),
      ),
    );
  }

  String? validateString(String? s, {required String? message}) {
    return s == null || s.isEmpty ? message : null;
  }

  void showSnackBar(BuildContext context, {String? message}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          duration: Duration(seconds: 5),
        )
    );
  }


}