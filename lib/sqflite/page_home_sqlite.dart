import 'package:android_ntu/helper/dialogs.dart';
import 'package:android_ntu/sqflite/page_user_detail.dart';
import 'package:android_ntu/sqflite/provider_data.dart';
import 'package:android_ntu/sqflite/sqlite_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class PageListUserSQLite extends StatefulWidget {
  const PageListUserSQLite({Key? key}) : super(key: key);

  @override
  State<PageListUserSQLite> createState() => _PageListUserSQLiteState();
}

class _PageListUserSQLiteState extends State<PageListUserSQLite> {
  BuildContext? _dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Demo"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageUserSQLiteDetail(xem: false),
                  )),
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: Consumer<DatabaseProvider>(
        builder: (context, database, child) {
          return FloatingActionButton(
            onPressed: () {
              if (database.users != null) {
                database.deleteTable();
                showSnackBar(context, "Xóa database", 1);
              } else {
                showSnackBar(context, "Không có dữ liệu!", 1);
              }
            },
            child: Icon(Icons.delete_forever),
          );
        },
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, child) {
          if (databaseProvider.users == null) {
            return const Center(
              child: Text("Lỗi kết nối dữ liệu!"),
            );
          } else {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                itemCount: databaseProvider.users!.length,
                itemBuilder: (context, index) {
                  _dialogContext = context;
                  User user = databaseProvider.users![index];
                  return Slidable(
                    child: ListTile(
                      leading: Text("${user.id}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      title: Text("${user.name}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.indigo)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Phone: ${user.phone}"),
                          Text("Email: ${user.email}"),
                        ],
                      ),
                    ),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                            onPressed: (context) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => PageUserSQLiteDetail(xem: true, user: user),)
                              );
                            },icon: Icons.details,
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.green[50]!,
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PageUserSQLiteDetail(xem: false, user: user),)
                            );
                          },icon: Icons.edit,
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue[50]!,
                        ),
                        SlidableAction(
                          onPressed: (context) => _xoa(_dialogContext, user),
                          icon: Icons.delete_forever,
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.red[50]!,
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    DatabaseProvider provider = context.read<DatabaseProvider>();
    provider.closeDatabase();
  }

  _xoa(BuildContext? dialogContext, User user) async {
    String? confirm = await showConfirmDialog(dialogContext!, "Bạn có muốn xóa ${user.name!}");
    if(confirm == "ok"){
      DatabaseProvider provider = context.read<DatabaseProvider>();
      provider.deleteUser(user.id!);
    }
  }
}
