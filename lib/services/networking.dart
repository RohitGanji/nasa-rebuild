import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:mongo_dart/mongo_dart.dart';


class Network {
  var db;

  openDB() async {
    db = await Db.create("mongodb+srv://<username>:<password>@cluster0.1g6nx.azure.mongodb.net/nasa?retryWrites=true&w=majority");
  await db.open();
}

  launchSchedule() async {
    await openDB();
    var coll = db.collection('launch_schedule');
    return await coll.find().toList();
  }

}

main() async {
  var start = DateTime.now().millisecondsSinceEpoch;
  Network network = Network();
  var res = await network.launchSchedule();
  print(res);
}
