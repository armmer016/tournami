import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tournami/login.dart';
import 'package:tournami/result.dart';
import 'package:tournami/verification_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAA3JdGT-qsSaHkVROg7eQeVdE0vMKhLzs",
          authDomain: "tournami.firebaseapp.com",
          projectId: "tournami",
          storageBucket: "tournami.appspot.com",
          messagingSenderId: "630227307963",
          appId: "1:630227307963:ios:d967e86acbc456da1e489e"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tournami',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
      routes: {
        "/home": (context) => MyHomePage(
              title: "home",
            ),
        "/verification": (context) => VerificationPage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  void press() {
    if (controller.text != "") {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ResultPage(
            query: controller.text,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 8,
          title: Text(
            "Text must not be empty",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Text("please fill in the search bar",
              style: Theme.of(context).textTheme.caption),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.15;
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                elevation: 8,
                title: Text("Are you sure to logout ?",
                    style: Theme.of(context).textTheme.bodyLarge),
                actionsPadding: EdgeInsets.symmetric(horizontal: 20),
                actionsOverflowButtonSpacing: 60,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/login',ModalRoute.withName('/'));
                      },
                      icon: const Text(
                        'Sure',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: padding / 2,
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "   A place where you want to go...",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontStyle: FontStyle.italic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton.icon(
                    onPressed: press,
                    icon: const Icon(Icons.search_rounded),
                    label: Text(
                      "Search",
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(
                  width: padding / 2,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              elevation: 8,
              title: Text(
                  "for education in ITCS424 Wireless And Mobile Computing MUICT / Tournami Group",
                  style: Theme.of(context).textTheme.caption),
            ),
          );
        },
        tooltip: 'more',
        child: const Icon(Icons.more),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
