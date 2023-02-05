
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_example/provider/item_list_provider.dart';
import 'package:riverpod_example/todo.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
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
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  Home(),
    );
  }
}

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final _controller=TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('todo'),),
      body: Column(

        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
                labelText: 'Enter todo..'
            ),

            onSubmitted: (value){
              ref.read(itemListProvider.notifier).addItem(
                Item(name: value),
              );
              print(value);


              _controller.clear();
            },
          ),
          // ElevatedButton(onPressed: (){
          //   watch.read(itemListProvider.notifier).addItem(
          //     Item(name: _controller.text),
          //   );
          //   _controller.clear();
          // }, child: Text('submit')),
          Expanded(
            child: Consumer(
              builder: (context,watch,child){
                final itemList= watch.watch(itemListProvider);
print(itemList);
                return ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index){
                    // watch.read(itemListProvider.notifier).deleteItem(item);
                    final Item item=itemList[index];
                    return Dismissible(
                      key: ValueKey(item.id),
                      onDismissed:(direction){
                        ref.read(itemListProvider.notifier).deleteItem(item);
                      } ,

                      child: CheckboxListTile(value: item.isDone,
                          title: Text(item.name),
                          onChanged: (value){
                       watch.
                            read(itemListProvider.notifier)
                            .updateItem(item..isDone = value??false);
                      }
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

