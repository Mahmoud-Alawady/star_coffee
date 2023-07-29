import 'package:sqflite/sqflite.dart';
import 'package:star_coffee/data/cart_item.dart';

class CartDatabase {
  static late String _dBsPath;
  static late String _cartDBPath;
  static late Database _database;
  static const String _tableName = 'Cart';
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
    _dBsPath = await getDatabasesPath();
    _cartDBPath = '$_dBsPath/cart.db';
    _database = await openDatabase(_cartDBPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $_tableName (
            $_id INTEGER PRIMARY KEY AUTOINCREMENT, 
            $_image TEXT, 
            $_title TEXT, 
            $_subtitle Text, 
            $_price REAL, 
            $_rate REAL,
            $_milkAmount INTEGER, 
            $_size INTEGER, 
            $_quantity INTEGER)
          ''');
    });
  }

  static insertRecord({required CartItem cartItem}) async {
    await openDB();

    await _database.transaction((txn) async {
      int processId = await txn.rawInsert('''
          INSERT INTO $_tableName($_image, $_title, $_subtitle, $_price, $_rate,$_milkAmount, $_size, $_quantity) 
          VALUES("${cartItem.drink.image}","${cartItem.drink.title}","${cartItem.drink.subtitle}", ${cartItem.drink.price}, ${cartItem.drink.rate}, ${cartItem.milkAmount}, ${cartItem.size}, ${cartItem.quantity})
          ''');
      print('inserted: $processId');

      // int id2 = await txn.rawInsert(
      //     'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
      //     ['another name', 12345678, 3.1416]);
      // print('inserted2: $id2');
    });
    _database.close();
  }

  static editRecord({required CartItem cartItem}) async {
    await openDB();
    int changesCount = await _database.rawUpdate(
        'UPDATE $_tableName SET $_image = "${cartItem.drink.image}", $_title = "${cartItem.drink.title}", $_subtitle = "${cartItem.drink.subtitle}", $_price = "${cartItem.drink.price}", $_rate = "${cartItem.drink.rate}", $_milkAmount = "${cartItem.milkAmount}", $_size = "${cartItem.size}", $_quantity = "${cartItem.quantity}" WHERE $_id = "${cartItem.id}"');
    print('updated: $changesCount');
    _database.close();
  }

  static editRecordQuantity({required CartItem cartItem}) async {
    await openDB();
    int changesCount = await _database.rawUpdate(
        'UPDATE $_tableName SET $_quantity = "${cartItem.quantity}" WHERE $_id = "${cartItem.id}"');
    print('changesCount: $changesCount');
    _database.close();
  }

  static Future<List<CartItem>> getCartItems() async {
    await openDB();
    List<Map> list = await _database.rawQuery('SELECT * FROM $_tableName');
    List<CartItem> cartItems = [];
    for (int i = 0; i < list.length; i++) {
      cartItems.add(CartItem.fromDB(list[i]));
    }
    // test code to be removed
    // await Future.delayed(const Duration(seconds: 2));
    // throw Exception('Can\'t load Items');
    // end
    _database.close();
    return cartItems;
  }

  static deleteDB() async {
    await deleteDatabase(_cartDBPath);
  }
}
