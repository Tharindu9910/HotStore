import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hot_store1/common_widgets/network_image.dart';
import 'package:hot_store1/models/product.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("View Product"),
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
                            children: [
                              RatingBar.builder(
                                initialRating: product!.rating?.rate ?? 1,
                                ignoreGestures: true,
                                minRating: 1,
                                itemSize: 15,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.zero,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Text("(${product!.rating?.rate ?? 1})")
                            ],
                          ),
                          SizedBox(
                              width: deviceSize.width * .3,
                              child: Text(
                                product!.category ?? "",
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              )),
                          SizedBox(
                              width: deviceSize.width * .3,
                              child: Text(
                                product!.title ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Text(
                            "\$${product!.price}",
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          )
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
