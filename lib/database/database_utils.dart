import 'package:login_database/user_modal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtils {
  DatabaseUtils._();

  static final DatabaseUtils db = DatabaseUtils._();

  Database? _database;
  bool? isEmail = true;

  String? path;

  String table = "CREATE TABLE logindata("
      "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "fName TEXT,"
      "lName TEXT,"
      "email TEXT,"
      "password TEXT"
      ")";

  get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    try {
      String databasePath = await getDatabasesPath();
      path = join(databasePath, "logindata.db");
      return await openDatabase(path ?? "", version: 1,
          onCreate: (Database database, int version) async {
        await database.execute(table);
      });
    } catch (e) {}
  }

  insertData(UserLoginModal userLoginModal) async {
    try {
      // Map<String, dynamic> map = {};
      // map["fName"] = "tarang";
      // map["lName"] = "tarang sardhara";
      // map["email"] = "tarang@gmail.com";

      final db = await database;
      await db?.insert("logindata", userLoginModal.toJson());
    } catch (e) {}
  }

  deleteData({required int id}) async {
    try {
      final db = await database;
       final result=await db?.rawDelete("DELETE FROM logindata WHERE id = ?",[id]);
    } catch (e) {}
  }

  upDateData({required int id,required String fname,required String lname,required String password}) async {
    try {
      final db = await database;
      final result=await db?.rawUpdate("UPDATE logindata SET fName=?,lName=?,password=? WHERE id = ?",[fname,lname,password,id]);
    } catch (e) {}
  }

  Future<List<UserLoginModal>> getData() async {
    UserLoginModal userLoginModal = UserLoginModal();
    List<UserLoginModal> userList = [];
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT * FROM logindata");
      result?.forEach((element) {
        userLoginModal = UserLoginModal.fromJson(element);
        userList.add(userLoginModal);
      });
    } catch (e) {}
    return userList;
  }
}
