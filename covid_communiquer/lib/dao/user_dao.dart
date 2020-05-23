import 'package:covid_communiquer/database/user_database.dart';
import 'package:covid_communiquer/model/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<User> getUserById(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return User.fromDatabaseJson(users.first);
      }
    } catch (error) {
      return null;
    }
  }

  Future<String> getUserToken(int id) async {
    final db = await dbProvider.database;
    try {
      var res = await db.rawQuery("SELECT token FROM userTable WHERE id=0");
      return res.isNotEmpty ? (User.fromDatabaseJson(res.first)).token : null;
    } catch (err) {
      return null;
    }
  }
}
