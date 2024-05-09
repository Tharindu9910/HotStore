import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hot_store1/utils/api_manager.dart';
import 'package:hot_store1/utils/padding_extensions.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopScreen> {
  List<String> categories = [];
  bool isLoading = false;

  @override
  void initState() {
    APIManager.fetchCategories().then((value) {
      setState(() {
        categories = value;
        isLoading = false;
      });
    }).catchError((error) {
      debugPrint("Error:$error");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          centerTitle: true,
          leading: GestureDetector(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new)),
          ),
          actions: [
            IconButton(
                onPressed: () => {}, icon: const Icon(Icons.search, size: 30))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('VIEW ALL ITEMS'),
                      ).paddingOnly(left: 10, right: 10, top: 10, bottom: 20),
                    ),
                  ],
                )),
            const Flexible(
                    flex: 1,
                    child: Text("Choose category",
                        style: TextStyle(color: Colors.black45)))
                .paddingOnly(left: 10),
            Flexible(
                flex: 4,
                child: ListView.separated(
                    itemCount: categories.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(categories[index],
                                style: TextStyle(fontSize: 20))
                            .paddingOnly(left: 20, top: 10),
                      );
                    })),
          ],
        ));
  }
}
