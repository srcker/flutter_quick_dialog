import 'package:flutter/material.dart';
import 'package:flutter_quick_dialog/quick_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'QuickToast Demo Home Page'),
      builder: QuickDialog.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(
              onPressed: () => QuickDialog.showModal(
                maskType: QuickDialogMaskType.black,
                title: "提示",
                content: "确定要删除该用户信息吗 \n 我可以自定义换行",
                dismissCallback: ()=>print("消失了！！"),
                cancelText: "辅助操作",
                confirmText: "主操作",
                confirmTextStyle: QuickDialogTheme.deleteTextStyle,
                cancelCallback: () => QuickDialog.dismiss(),
                confirmCallback: ()=> QuickDialog.dismiss(),
              ),
              child: const Text("删除确认"),
            ),

            ElevatedButton(
              onPressed: () => QuickDialog.showModal(
                maskType: QuickDialogMaskType.black,
                title: "弹窗标题",
                content: "弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内",
                dismissCallback: ()=>print("消失了！！"),
                cancelText: "辅助操作",
                confirmText: "主操作",
                cancelCallback: () => QuickDialog.dismiss(),
                confirmCallback: ()=> QuickDialog.dismiss(),
              ),
              child: const Text("样式一"),
            ),

            ElevatedButton(
              onPressed: () => QuickDialog.showModal(
                maskType: QuickDialogMaskType.black,
                title: "弹窗标题",
                content: "弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内",
                dismissCallback: ()=>print("消失了！！"),
                cancelText: "辅助操作",
                confirmText: "主操作",
                buttonAlignment: QuickDialogButtonAlignment.vertical,
                cancelCallback: () => QuickDialog.dismiss(),
                confirmCallback: ()=> QuickDialog.dismiss(),
              ),
              child: const Text("样式二"),
            ),

            ElevatedButton(
              onPressed: () => QuickDialog.showModal(
                maskType: QuickDialogMaskType.black,
                title: "弹窗标题",
                content: "弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内",
                dismissCallback: ()=>print("消失了！！"),
                cancelText: "辅助操作",
                confirmText: "主操作",
                contentMargin: EdgeInsets.zero,
                radius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                position: QuickDialogPosition.top,
                animation: QuickDialogAnimationStyle.offset,
                cancelCallback: () => QuickDialog.dismiss(),
                confirmCallback: ()=> QuickDialog.dismiss(),
              ),
              child: const Text("头部弹出"),
              
            ),

            ElevatedButton(
              onPressed: () => QuickDialog.showModal(
                maskType: QuickDialogMaskType.black,
                title: "弹窗标题",
                content: "弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内",
                dismissCallback: ()=>print("消失了！！"),
                cancelText: "辅助操作",
                confirmText: "主操作",
                contentMargin: EdgeInsets.zero,
                radius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                position: QuickDialogPosition.bottom,
                animation: QuickDialogAnimationStyle.offset,
                cancelCallback: () => QuickDialog.dismiss(),
                confirmCallback: ()=> QuickDialog.dismiss(),
              ),
              child: const Text("底部弹出"),
            ),

            ElevatedButton(
              onPressed: () => QuickDialog.showDialog(
                maskType: QuickDialogMaskType.black,
                dismissCallback: ()=>print("消失了！！"),
                position: QuickDialogPosition.top,
                animation: QuickDialogAnimationStyle.offset,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                    gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                        Color(0xFF2768FB),
                                        Color(0xFF4E20FC),
                                        Color(0xFF3AC8E8),
                                    ]
                                ),
                            ),
                            child: SafeArea(child: Row(
                                children: [

                                    Container(
                                        width: 45,
                                        height: 45,
                                        margin: const EdgeInsets.only(right: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.white,
                                        ),
                                        child: const Icon(Icons.notifications, size: 40, color: Color(0xFF0F5BFB) ),
                                    ),

                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            const Text("系统提示👏", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),),
                                            Text("当前账户可用时间不足", style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8))),
                                        ],
                                    )
                                ],
                            ))
                        )
                    ],
                )
              ),
              child: const Text("显示弹窗"),
            ),


          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
