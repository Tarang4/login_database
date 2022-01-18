import 'package:login_database/user_modal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtils {
  DatabaseUtils._();

  static final DatabaseUtils db = DatabaseUtils._();

  Database? _database;
  bool? isEmail = true;

  String? path;

  String table = "CREATE TABLE loginData("
      "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "fName TEXT,"
      "lName TEXT,"
      "email TEXT,"
      "password TEXT"
      "img TEXT,"
      "phone INTEGER,"
      "gender INTEGER,"
      "address TEXT,"
      "city TEXT,"
      "pinCode INTEGER"
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
      path = join(databasePath, "loginData.db");
      return await openDatabase(path ?? "", version: 1,
          onCreate: (Database database, int version) async {
        await database.execute(table);
      });
    } catch (e) {}
  }

  insertData(UserLoginModal userLoginModal) async {
    try {
      Map<String, dynamic> map = {};
      map["fName"] = userLoginModal.fName;
      map["lName"] = userLoginModal.lName;
      map["email"] = userLoginModal.email;
      map["password"] = userLoginModal.password;

      final db = await database;
      await db?.insert("loginData", map);
    } catch (e) {
      print(e);
    }
  }

  deleteData({required int id}) async {
    try {
      final db = await database;
      final result =
          await db?.rawDelete("DELETE FROM loginData WHERE id = ?", [id]);
    } catch (e) {}
  }

  upDateData(UserLoginModal userLoginModal) async {
    try {
      Map<String, dynamic> map = {};
      map["fName"] = userLoginModal.fName;
      map["lName"] = userLoginModal.lName;
      map["img"] = userLoginModal.img;
      map["phone"] = userLoginModal.phone;
      map["gender"] = userLoginModal.gender;
      map["address"] = userLoginModal.address;
      map["city"] = userLoginModal.city;
      map["pinCode"] = userLoginModal.pinCode;
      final db = await database;
      await db?.Update("loginData", map,
          where: 'email=?', whereArgs: [userLoginModal.email]);
    } catch (e) {}
  }

  Future<List<UserLoginModal>> getData() async {
    UserLoginModal userLoginModal = UserLoginModal();
    List<UserLoginModal> userList = [];
    try {
      final db = await database;
      final result = await db.rawQuery("SELECT * FROM loginData");
      result?.forEach((element) {
        userLoginModal = UserLoginModal.fromJson(element);
        userList.add(userLoginModal);
      });
    } catch (e) {}
    return userList;
  }
}
