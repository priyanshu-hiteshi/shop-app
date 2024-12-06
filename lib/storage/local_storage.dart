abstract class LocalStorage {
  Future<List<String>?> getStringList(String key);
  Future<void> setStringList(String key, List<String> value);
  Future<void> addString(String key, String value);
  Future<void> deleteString(String key, String value);
}


//Notes :- Here we have created the abstraction layer 
// trailing: Text(
         //   "\$${widget.product.price.toStringAsFixed(2)}",
           // style: const TextStyle(color: Colors.green),
          //),
