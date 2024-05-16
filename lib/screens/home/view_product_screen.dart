import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hot_store1/common_widgets/network_image.dart';
import 'package:hot_store1/models/product.dart';
import 'package:hot_store1/screens/home/widgets/color_selection.dart';
import 'package:hot_store1/screens/home/widgets/size_selection.dart';
import 'package:hot_store1/utils/padding_extensions.dart';

import '../../utils/api_manager.dart';

class ViewProductArgs {
  final int productID;

  ViewProductArgs({required this.productID});
}

class ViewProductScreen extends StatefulWidget {
  final ViewProductArgs args;

  const ViewProductScreen({super.key, required this.args});

  @override
  State<ViewProductScreen> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductScreen> {
  bool isLoading = false;
  Product? product;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    APIManager.fetchProduct(widget.args.productID).then((value) {
      setState(() {
        product = value;
        isLoading = false;
      });
    }).catchError((error) {
      debugPrint("Error: $error");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(product?.title ?? 'Loading..'),
        centerTitle: true,
        leading: GestureDetector(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        actions: [
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.share, size: 25))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                product == null
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppNetworkImage(
                            imageUrl: product!.image!,
                            height: deviceSize.height * 0.5,
                            // width: deviceSize.width * 0.27,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  child: Container(
                                      height: deviceSize.height * 0.08,
                                      width: deviceSize.width * 0.32,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.black45),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Size"),
                                          Icon(
                                              Icons.keyboard_arrow_down_rounded)
                                        ],
                                      )),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const SizeSelection(),
                                    );
                                  }),
                              GestureDetector(
                                child: Container(
                                    height: deviceSize.height * 0.08,
                                    width: deviceSize.width * 0.32,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black45),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Color"),
                                        Icon(Icons.keyboard_arrow_down_rounded)
                                      ],
                                    )).paddingAll(20),
                                onTap: () {
                                  // showModalBottomSheet(
                                  //   context: context,
                                  //   builder: (context) =>
                                  //       const ColorSelection(),
                                  // );
                                },
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.08,
                                child: FloatingActionButton(
                                  onPressed: () {}, // icon of the button
                                  shape: CircleBorder(),
                                  backgroundColor: Colors.white, // Button color
                                  foregroundColor: Colors.black45,
                                  child: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.black45,
                                  ), // Splash color
                                ),
                              ),
                            ],
                          ).paddingLTRB(
                              left: 20, top: 5, right: 20, bottom: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                  width: deviceSize.width * .65,
                                  child: Text(
                                    product!.title ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Text(
                                "\$${product!.price}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ).paddingOnly(left: 20, right: 20),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                                width: deviceSize.width * .3,
                                child: Text(
                                  product!.category ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 12, color: Colors.black45),
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ).paddingStart(24),
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: product!.rating?.rate ?? 1,
                                ignoreGestures: true,
                                minRating: 1,
                                itemSize: 15,
                                //direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.zero,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Text("(${product!.rating?.rate ?? 1})")
                            ],
                          ).paddingOnly(left: 22, top: 10),
                          SizedBox(
                              child: Text(
                            product!.description ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.clip,
                          )).paddingAll(20),
                        ],
                      )
              ],
            ),
          ),
          Visibility(
            visible: isLoading,
            child: const Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
