import 'package:android_ntu/page_home.dart';
import 'package:flutter/material.dart';

class PageMyProfile extends StatefulWidget {
  const PageMyProfile({Key? key}) : super(key: key);

  @override
  State<PageMyProfile> createState() => _PageMyProfileState();
}

class _PageMyProfileState extends State<PageMyProfile> {
  String gioiTinh = "Nam";
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("My Profile"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("test"),
                accountEmail: Text("test@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/background.jpg"),
                ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              trailing: Text("10"),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PageHome(),));
                  },
                leading: Icon(Icons.output_sharp),
                title: Text("Exit"),
                trailing: Text("10"),
                ),
              ),
            )
            
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.lightBlue,
                Colors.white,
              ],
            ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Image.asset("assets/images/background.jpg")
            ),
            SizedBox(height: 15),
            Text("Họ tên: ", style: TextStyle(color: Colors.black)),
            Text("Chưa Qua Môn", style: TextStyle(fontSize: 20, color: Colors.white,shadows: <Shadow>[
              Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(255, 255, 255, 0),
              ),
            ], fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Text("Ngày sinh:",style: TextStyle(color: Colors.black)),
            Text("14/2/2023", style: TextStyle(fontSize: 20, color: Colors.black)),
            SizedBox(height: 15),
            Text("Giới tính:",style: TextStyle(color: Colors.black)),
            Theme(data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.white,
                disabledColor: Colors.blue
            ), child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Radio(
                      value: "Nam",
                      groupValue: gioiTinh,
                      onChanged: (value){
                        setState(() {
                          gioiTinh = value as String;
                        });
                      },
                    ),
                    title: Text("Nam",style: TextStyle(color: Colors.black)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Radio(
                      value: "Nữ",
                      groupValue: gioiTinh,
                      onChanged: (value) {
                        setState(() {
                          gioiTinh = value as String;
                        });
                      },
                    ),
                    title: Text("Nữ",style: TextStyle(color: Colors.black)),
                  ),
                )
              ],
            ),),
            SizedBox(height: 15),
            Text("Quê quán:", style: TextStyle(color: Colors.black)),
            Text("Nha Trang, Khánh Hòa", style: TextStyle(fontSize: 20, color: Colors.black)),
            SizedBox(height: 15),
            Text("Sở thích:", style: TextStyle(color: Colors.black)),
            Text("Ngủ nướng...", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          switch (value) {
            case 0:
              _showSnackbar(context, "Bạn mở Inbox");
              break;
            case 1:
              _showSnackbar(context, "Bạn mở Contact");
              break;
            case 2:
              _showSnackbar(context, "Bạn mở Calendar");
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Inbox",
            icon: Icon(Icons.inbox),
          ),
          BottomNavigationBarItem(
            label: "Contact",
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            label: "Calendar",
            icon: Icon(Icons.calendar_today),
          )
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.grey[600],
        )
    );
  }
}
