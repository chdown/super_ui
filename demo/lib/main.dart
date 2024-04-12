import 'package:flutter/material.dart';
import 'package:super_ui/super_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SuperCard(
              width: double.infinity,
              image: DecorationImage(image: AssetImage("assets/images/bg_revoke.png"), alignment: Alignment(0.9, -0.9), scale: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SuperButton(
                    width: 200,
                    margin: EdgeInsets.all(10),
                    height: 80,
                    type: ButtonType.filled,
                    prefixWidget: Icon(Icons.confirmation_num_sharp),
                    suffixWidget: Icon(Icons.confirmation_num_sharp),
                    text: '111111111',
                    onTap: () {},
                  ),
                  SuperButton(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 80,
                    type: ButtonType.outlined,
                    prefixWidget: Icon(Icons.confirmation_num_sharp),
                    suffixWidget: Icon(Icons.confirmation_num_sharp),
                    text: '222222222',
                    textColor: Colors.black45,
                    onTap: () {},
                  ),
                  SuperButton(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 80,
                    type: ButtonType.outlinedPrimary,
                    prefixWidget: Icon(Icons.confirmation_num_sharp),
                    suffixWidget: Icon(Icons.confirmation_num_sharp),
                    text: '333333333',
                    onTap: () {},
                  ),
                  SuperButton(
                    width: 200,
                    margin: EdgeInsets.all(10),
                    height: 80,
                    type: ButtonType.text,
                    text: '444444444',
                    prefixWidget: Icon(Icons.confirmation_num_sharp),
                    suffixWidget: Icon(Icons.confirmation_num_sharp),
                    onTap: () {},
                  ),
                  SuperButton(
                    width: 200,
                    height: 80,
                    margin: EdgeInsets.all(10),
                    type: ButtonType.textPrimary,
                    prefixWidget: Icon(Icons.confirmation_num_sharp),
                    suffixWidget: Icon(Icons.confirmation_num_sharp),
                    text: '55555555',
                    onTap: () {},
                  ),
                  SuperDivider(),
                  SuperButton(
                    type: ButtonType.filled,
                    text: '111111111',
                    onTap: () {},
                    enabled: false,
                  ),
                  SuperButton(
                    type: ButtonType.outlined,
                    textColor: Colors.black,
                    text: '222222222',
                    onTap: () {},
                    enabled: false,
                  ),
                  SuperButton(
                    type: ButtonType.outlinedPrimary,
                    text: '333333333',
                    onTap: () {},
                    enabled: false,
                  ),
                  SuperButton(
                    type: ButtonType.text,
                    text: '444444444',
                    padding: EdgeInsets.zero,
                    onTap: () {},
                    enabled: false,
                  ),
                  SuperButton(
                    type: ButtonType.textPrimary,
                    text: '55555555',
                    onTap: () {},
                    enabled: false,
                  ),
                  SuperDivider(),
                  FilledButton(onPressed: () {}, child: Text("1111")),
                  OutlinedButton(onPressed: () {}, child: Text("1111")),
                  TextButton(onPressed: () {}, child: Text("1111")),
                ],
              ),
            ),
            Text('data'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
