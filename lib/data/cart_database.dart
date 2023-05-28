import 'package:sqflite/sqflite.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/data/drink.dart';

class CartDatabase {
  static late String databasesPath;
  static late String path;
  static late Database database;
  static const String tableName = 'Cart';
  static const String _id = 'id';
  static const String _image = 'image';
  static const String _title = 'title';
  static const String _subtitle = 'subtitle';
  static const String _price = 'price';
  static const String _rate = 'rate';
  static const String _milkAmount = 'milkAmount';
  static const String _size = 'size';
  static const String _quantity = 'quantity';

  static openDB() async {
    databasesPath = await getDatabasesPath();
    path = '${databasesPath}cart.db';

    // open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName ($_id INTEGER PRIMARY KEY, $_image TEXT, $_title TEXT, $_subtitle Text, $_price REAL, $_rate REAL,$_milkAmount REAL, $_size INTEGER, $_quantity INTEGER)');
    });
  }

  static insertRecord(
    String image,
    String title,
    String subtitle,
    double price,
    double rate,
    double milkAmount,
    int size,
    int quantity,
  ) async {
    await openDB();
    await database.transaction((txn) async {
      int processId = await txn.rawInsert(
          'INSERT INTO $tableName($_image, $_title, $_subtitle, $_price, $_rate,$_milkAmount, $_size, $_quantity) VALUES("$image","$title","$subtitle", $price, $rate, $milkAmount, $size, $quantity)');
      print('inserted: $processId');

      // int id2 = await txn.rawInsert(
      //     'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
      //     ['another name', 12345678, 3.1416]);
      // print('inserted2: $id2');
    });
  }

  static Future<List<CartItem>> getRecord() async {
    await openDB();
    List<Map> list = await database.rawQuery('SELECT * FROM $tableName');
    print(list);
    List<CartItem> itemsList = [];
    for (int i = 0; i < list.length; i++) {
      itemsList.add(
        CartItem(
            drink: Drink(
                image: list[i]['image'],
                title: list[i]['title'],
                subtitle: list[i]['subtitle'],
                price: list[i]['price'],
                rate: list[i]['rate']),
            milkAmount: list[i]['milkAmount'],
            size: list[i]['size'],
            quantity: list[i]['quantity']),
      );
    }

    print(itemsList);
    return itemsList;
  }

  static deleteDB() async {
    // Delete the database
    await deleteDatabase(path);
  }

  static editRecord(
    int id,
    String image,
    String title,
    String subtitle,
    double price,
    double rate,
    double milkAmount,
    int size,
    int quantity,
  ) async {
    // Update some record
    int updatedValue = await database.rawUpdate(
        'UPDATE $tableName SET $_image = ?, $_title = ?, $_subtitle = ?, $_price = ?, $_rate = ?, $_milkAmount = ?, $_size = ?, $_quantity = ?, WHERE $_id = ?',
        [
          image,
          title,
          subtitle,
          price,
          rate,
          milkAmount,
          size,
          quantity,
          id,
        ]);
    print('updated: $updatedValue');
  }
}
