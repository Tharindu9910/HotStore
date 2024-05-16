import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hot_store1/common_widgets/network_image.dart';
import 'package:hot_store1/screens/home/view_product_screen.dart';
import 'package:hot_store1/screens/routes.dart';
import 'package:hot_store1/utils/api_manager.dart';
import 'package:hot_store1/utils/padding_extensions.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  List<Product>? products;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialization();
    setState(() {
      isLoading = true;
    });
    APIManager.fetchProducts().then((value) {
      setState(() {
        products = value;
        isLoading = false;
      });
    }).catchError((error) {
      debugPrint("Error: $error");
    });
    super.initState();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                products == null
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/homeMain.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                "Fashion\nsale",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                        fontSize: 55.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ).paddingLTRB(
                                  left: 20.0,
                                  top: 250.0,
                                  right: 0.0,
                                  bottom: 0.0),
                              ElevatedButton(
                                onPressed: () {
                                  checkSale();
                                },
                                child: Text("Check").paddingLTRB(
                                    left: 30, top: 0, right: 30, bottom: 0),
                              ).paddingLTRB(
                                  left: 20.0,
                                  top: 385.0,
                                  right: 0.0,
                                  bottom: 0.0),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "New",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "View all",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(fontSize: 15),
                              ),
                            ],
                          ).paddingOnly(left: 20, right: 20, top: 20),
                          Text(
                            "You've never seen it before!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.black45),
                          ).paddingStart(20),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: ListView.builder(
                                  itemCount: products!.length,
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var item = products![index];
                                    var deviceSize =
                                        MediaQuery.of(context).size;
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            AppRouter.viewProductScreen,
                                            arguments: ViewProductArgs(
                                                productID: item.id ?? 1));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppNetworkImage(
                                            imageUrl: item.image!,
                                            height: deviceSize.height * 0.2,
                                            width: deviceSize.width * 0.30,
                                          ),
                                          Row(
                                            children: [
                                              RatingBar.builder(
                                                initialRating:
                                                    item.rating?.rate ?? 1,
                                                ignoreGestures: true,
                                                minRating: 1,
                                                itemSize: 15,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.zero,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  // print(rating);
                                                },
                                              ),
                                              Text(
                                                  "(${item.rating?.rate ?? 1})")
                                            ],
                                          ),
                                          SizedBox(
                                              width: deviceSize.width * .3,
                                              child: Text(
                                                item.category ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          SizedBox(
                                              width: deviceSize.width * .3,
                                              child: Text(
                                                item.title ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          Text(
                                            "\$${item.price}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    )
                                        .paddingSymmetric(horizontal: 10)
                                        .paddingTop(10);
                                  })).paddingAll(10),
                        ],
                      )
              ],
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Center(child: const CircularProgressIndicator()),
          )
        ],
      ),
    );
  }

  void checkSale() {}
}
