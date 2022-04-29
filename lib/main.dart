import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() async{
  runApp(const MyApp());
  GoogleTranslator translator = GoogleTranslator();

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  var output;
  String? dropdownValue;

  static const Map<String, String> lang = {
    "Telugu": "te",
    "English": "en",
  };
  var translation;
  void transfer()async{
    translation = await translator.translate("Vennu ", to: 'te');

    setState(() {
      print("language is  ${translation.toString()}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      transfer();
    });
  }
  void trans() {
    translator
        .translate(textEditingController.text, from: 'en',to: "$dropdownValue")
        .then((value) {
      setState(() {
        output = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Multi Language Translator"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  controller: textEditingController,
                  // onTap: () {
                  //   trans();
                  // },
                  decoration: InputDecoration(
                      labelText: 'Type Here',
                      labelStyle: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Select Language here =>"),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        trans();
                      });
                    },
                    items: lang
                        .map((string, value) {
                      return MapEntry(
                        string,
                        DropdownMenuItem<String>(
                          value: value,
                          child: Text(string),
                        ),
                      );
                    })
                        .values
                        .toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text('Translated Text'),
              SizedBox(
                height: 10,
              ),
              Text(translation.toString() == null? "Not Loaded" : translation.toString(),style: TextStyle(fontSize: 32),),
              Text("",style: TextStyle(fontSize: 32),),
              Text(
                output == null ? "Please Select Language" : output.toString(),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
