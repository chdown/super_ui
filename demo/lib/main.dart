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
              image: const DecorationImage(image: AssetImage("assets/images/bg_revoke.png"), alignment: Alignment(0.9, -0.9), scale: 3),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SuperItemText(
                  title: 'title',
                  itemIconType: ItemIconType.down,
                  onTap: (content) {},
                ),
                const SuperDivider(isDashed: true),
                SuperButton(
                  type: ButtonType.text,
                  text: '测试',
                  margin: EdgeInsets.zero,
                  onTap: () {},
                ),
                SuperButton(
                  type: ButtonType.filled,
                  text: '测试',
                  margin: EdgeInsets.zero,
                  onTap: () {},
                ),
                SuperButton(
                  type: ButtonType.outlinedPrimary,
                  text: '测试',
                  margin: EdgeInsets.zero,
                  onTap: () {},
                ),
                SuperButton(
                  type: ButtonType.outlined,
                  text: '测试',
                  margin: EdgeInsets.zero,
                  onTap: () {},
                ),
              ]),
            ),
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
