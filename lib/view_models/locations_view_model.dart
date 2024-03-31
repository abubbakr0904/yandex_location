import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:yandex_location/data/models/location_model.dart';


class LocationsViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<PlaceModel> categoryProduct = [];

  Stream<List<PlaceModel>> listenProducts() => FirebaseFirestore.instance
      .collection("locations")
      .snapshots()
      .map(
        (event) =>
        event.docs.map((doc) => PlaceModel.fromJson(doc.data())).toList(),
  );


  insertProducts(PlaceModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection("locations")
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection("locations")
          .doc(cf.id)
          .update({"doc_id": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      debugPrint("xatoku");
    }
    notifyListeners();
  }

  deleteProduct(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection("locations")
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      debugPrint("kotku");
    }
  }


  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}