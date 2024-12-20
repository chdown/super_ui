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
  TextEditingController textEditingController = TextEditingController();
  bool visible = false;

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
            SuperButton(
                type: ButtonType.filled,
                text: "text",
                onTap: () {
                  visible = !visible;
                  textEditingController.clear();
                  setState(() {});
                }),
            SuperButton(
                type: ButtonType.filled,
                text: "text",
                onTap: () {
                  textEditingController.text;
                }),
            if (visible)
              SuperTextFiled(
                keyboardType: KeyboardType.number,
                style: TextFiledStyle.outline,
                maxLength: 3,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                hintText: "请输入售卖时长",
                controller: textEditingController,
                isCollapsed: true,
                borderRadius: 4,
                borderWidth: 0.5,
                onChanged: (value) {
                  print(textEditingController.text);
                  print(value);
                },
              )
            // SuperCard(
            //   width: double.infinity,
            //   image: const DecorationImage(image: AssetImage("assets/images/bg_revoke.png"), alignment: Alignment(0.9, -0.9), scale: 3),
            //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //     SuperItemText(
            //       title: 'title',
            //       itemIconType: ItemIconType.down,
            //       onTap: (content) {},
            //     ),
            //     const SuperDivider(isDashed: true),
            //     SuperButton(
            //       type: ButtonType.text,
            //       text: '测试',
            //       margin: EdgeInsets.zero,
            //       onTap: () {},
            //     ),
            //   ]),
            // ),
            // Container(
            //   height: 120,
            //   color: Colors.amber,
            //   child: TextField(
            //     decoration: InputDecoration(
            //       // constraints: BoxConstraints.tight(Size(double.infinity, 120)),
            //       // isCollapsed: true,
            //       // isDense: true,
            //       fillColor: Colors.blueAccent,
            //       // contentPadding: EdgeInsets.only(top: 30, bottom: 30),
            //       filled: true,
            //       labelText: '出生日期：',
            //       prefixIcon: SuperIcon.icon(Icons.ac_unit),
            //     ),
            //   ),
            // ),
            // SuperTextFiled(
            //   isCollapsed: true,
            //   heightH: 33.6,
            //   style: TextFiledStyle.fill,
            //   fillColor: const Color(0xFFF4FCFC),
            //   // contentPadding: EdgeInsets.only(top: 12.w, bottom: 12.w, left: 12.w, right: 12.w),
            //   autofocus: false,
            //   // controller: controller.textEditingController,
            //   // suffixIcon: Image.asset(
            //   //   Assets.imagesIvSearch,
            //   //   width: 30.w,
            //   //   height: 30.w,
            //   // ),
            //   hintText: '请输入搜索内容',
            //   onSubmitted: (text) {
            //     // controller.refreshController.requestRefresh(needMove: false);
            //   },
            // ),
            // SizedBox(height: 20),
            // Container(
            //   height: 120,
            //   color: Colors.amber,
            //   child: const TextField(
            //     // Padding 置为左右 24，上 0 下 80
            //     decoration: InputDecoration(
            //       // constraints: BoxConstraints.expand(height: 120),
            //       // isCollapsed: true,
            //       // isDense: true,
            //       fillColor: Colors.blueAccent,
            //       // isDense: true,
            //       isCollapsed: true,
            //       // contentPadding: EdgeInsets.all(6),
            //       // contentPadding: EdgeInsets.only(top: 12),
            //       // contentPadding: EdgeInsets.only(top: 30, bottom: 30),
            //       filled: true,
            //       // labelText: '出生日期：',
            //       // suffixIcon: SizedBox(
            //       //   height: 20,
            //       //   width: 20,
            //       //   child: Icon(
            //       //     Icons.cancel,
            //       //     opticalSize: 18,
            //       //     size: 18,
            //       //     color: Color(0xFF999999),
            //       //   ),
            //       // ),
            //       // suffixIconConstraints: BoxConstraints(minHeight: 30)
            //       // prefixIconConstraints: BoxConstraints.tightFor(height: 24),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 30),
            // SuperTextFiled(
            //   isDense: true,
            //   fillColor: Colors.cyanAccent,
            //   // contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 40),
            //   heightH: 90,
            //   prefixIcon: SizedBox(
            //     height: 20,
            //     width: 20,
            //     child: Icon(
            //       Icons.cancel,
            //       opticalSize: 18,
            //       size: 18,
            //       color: Color(0xFF999999),
            //     ),
            //   ),
            // ),
            // SuperButton(
            //   type: ButtonType.text,
            //   text: '测试',
            //   margin: EdgeInsets.zero,
            //   onTap: () {},
            // ),
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
