// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat("dd.MM.yyyy");

class FamilyTree {
  FamilyNode root;
  FamilyTree(this.root);
  FamilyTree.fromJson(Map<String, dynamic> json)
      : root = FamilyNode.fromJson(json['root']!, null);

  Map<String, dynamic> toJson() {
    return {"root": root.toJson()};
  }

  void show() {
    var treeText = "";
    treeText = bfsShow(root, treeText, 0);
    print(treeText);
  }

  String bfsShow(FamilyNode? current, String tree, int depth) {
    if (current == null) {
      return tree;
    }
    var name = current.getName();
    tree = "$tree$name";
    for (final child in current.children) {
      tree += "\n";
      for (int i = 0; i <= depth; i++) {
        tree += "-";
      }
      tree += " ";
      tree = bfsShow(child, tree, depth + 1);
    }
    return tree;
  }
}

class FamilyNode {
  String name;
  DateTime? birthday;
  DateTime? death;
  FamilyNode? spouse;
  FamilyNode? parent;
  List<FamilyNode> children = [];
  FamilyNode(this.name, this.parent, this.spouse, this.children, this.birthday,
      this.death);
  FamilyNode.orphan(String nodeName)
      : name = nodeName,
        parent = null,
        spouse = null,
        birthday = null,
        death = null,
        children = [];
  FamilyNode.child(String nodeName, FamilyNode? nodeParent)
      : name = nodeName,
        parent = nodeParent,
        spouse = null,
        birthday = null,
        death = null,
        children = [];
  factory FamilyNode.fromJson(
      Map<String, dynamic> json, FamilyNode? nodeParent) {
    FamilyNode node = FamilyNode.orphan(json["name"]);
    node.parent = nodeParent;
    node.birthday =
        json["birthday"] == null ? null : formatter.parse(json["birthday"]);
    node.death = json["death"] == null ? null : formatter.parse(json["death"]);
    node.spouse = json["spouse"] == null
        ? null
        : FamilyNode.fromJson(json["spouse"], null);
    node.children = [];
    if (json["children"] != null) {
      for (dynamic child in json["children"]) {
        node.addChild(FamilyNode.fromJson(child, node));
      }
    }
    return node;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> out = {
      "name": name,
    };
    birthday != null ? out["birthday"] = formatter.format(birthday!) : null;
    death != null ? out["death"] = formatter.format(death!) : null;
    spouse != null ? out["spouse"] = spouse!.toJson() : null;
    children.isNotEmpty
        ? out["children"] = children.map((child) => child.toJson()).toList()
        : null;
    return out;
  }

  void addChild(FamilyNode child) {
    child.parent = this;
    children.add(child);
  }

  void changeBirthday(DateTime date) {
    birthday = date;
  }

  void changeDeath(DateTime date) {
    death = date;
  }

  void changeSpouse(FamilyNode spouse) {
    this.spouse = spouse;
  }

  void changeParent(FamilyNode newParent) {
    parent = newParent;
  }

  FamilyNode? getChildOrNull(String name) {
    for (final child in children) {
      if (child.name == name) {
        return child;
      }
    }
    return null;
  }

  FamilyNode? getParent() {
    return parent;
  }

  String getName() {
    return name;
  }
}

void main() async {
  var input = await File("./data/tree.json").readAsString();
  var tree = FamilyTree.fromJson(jsonDecode(input));
  tree.show();
  print(tree.toJson());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
