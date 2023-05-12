import 'package:android_ntu/form/form_model.dart';
import 'package:flutter/material.dart';

class PageFormMatHang extends StatelessWidget { //alt + enter, chen
  PageFormMatHang({Key? key}) : super(key: key);
  // để tương tác được với form thì ta phải khai báo một global key
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  MatHang m = MatHang();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSoLuong = TextEditingController();
  String? dropdownValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Mat Hang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled, // khi nào gọi phương thức validate() trên form, nó mới xác thực các thông tin ta nhập vào
          child: Column(
            children: [
              TextFormField(
                controller: txtName,
                onSaved: (newValue) => m.name = newValue,
                decoration: InputDecoration(
                  labelText: "Tên mặt hàng",
                ),
                validator: (value) => validateString(value, message: "Bạn chưa nhập dữ liệu!"), // validate string
              ), // để nhập liệu được, ta phải khai bảo TextEdittingController
              DropdownButtonFormField<String>(
                  items: loaiMHs.map((loaiHang) =>
                      DropdownMenuItem<String>(
                          child: Text("${loaiHang}"),  // child là hiển thị để chọn,
                        value: loaiHang, // giá trị của mục chọn
                      ),
                      ).toList(),
                  onChanged: (value) => dropdownValue = value,
                  onSaved: (newValue) => m.loaiMH = newValue,
                  // mỗi dropdownbutton có value,
                  value: dropdownValue,
                  decoration: InputDecoration(
                    labelText: "Loại mặt hàng",
                  ),
                  validator: (value) => validateString(value, message: "Bạn chưa nhập dữ liệu!"),
              ),
              TextFormField(
                controller: txtSoLuong,
                keyboardType: TextInputType.number, // đổi loại bàn phím
                onSaved: (newValue) => m.soLuong = int.parse(newValue!), // validate thì mới hết null
                validator: (value) => validateSoLuong(value),
                decoration: InputDecoration(
                  labelText: "Số lượng",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      // onPressed: () => _save(context),
                    onPressed: () {
                      formState.currentState?.validate();  // test validate
                      _save(context);
                    },
                      child: Text("Submit")
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _save(BuildContext context) {
    if(formState.currentState!.validate()) { // có thể null
      formState.currentState!.save(); // gọi các phương thức onSave => gán giá trị nhập vào object m
      hienthiDialog(context);
    }
  }

  validateString(String? value, {required message}) {
    return value == null || value.isEmpty ? message : null;
  }

  validateSoLuong(String? value) {
    if (value == null || value.isEmpty) {
      return "Bạn chưa nhập số lượng!";
    } else {
      return int.parse(value) < 0 ? "Số lượng không được phép nhỏ hơn 0" : null;
    }
  }

  void hienthiDialog(BuildContext context) {
    var dialog = AlertDialog(
      title: Text("Text"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // column sẽ chiếm hết diện tích màn hình => muốn chỉ chiếm diện tích vừa đủ hiển thị
        children: [
          Text("Bạn đã nhập mặt hàng!"),
          Text("Tên mặt hàng: ${m.name}"),
          Text("Loại mặt hàng: ${m.loaiMH}"),
          Text("Số lượng: ${m.soLuong}"),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("OK"))
      ],
    );
    showDialog(context: context, builder: (context) => dialog,);
  }
}
