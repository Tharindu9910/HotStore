import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_store1/utils/padding_extensions.dart';

class SizeSelection extends StatefulWidget {
  const SizeSelection({super.key});

  @override
  State<SizeSelection> createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Wrap(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Selected size",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: deviceSize.height * 0.06,
                    width: deviceSize.width * 0.22,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("XS"),
                      ],
                    )),
                Container(
                    height: deviceSize.height * 0.06,
                    width: deviceSize.width * 0.22,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("S"),
                      ],
                    )),
                Container(
                    height: deviceSize.height * 0.06,
                    width: deviceSize.width * 0.22,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("M"),
                      ],
                    )),
              ],
            ).paddingLTRB(left: 20, top: 20, right: 20, bottom: 10),
            Row(
              children: [
                Container(
                    height: deviceSize.height * 0.06,
                    width: deviceSize.width * 0.22,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("L"),
                      ],
                    )).paddingStart(30),
                Container(
                    height: deviceSize.height * 0.06,
                    width: deviceSize.width * 0.22,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("XL"),
                      ],
                    )).paddingStart(20),
              ],
            ).paddingBottom(20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('ADD TO CART'),
                  ).paddingOnly(left: 10, right: 10, top: 10, bottom: 20),
                ),
              ],
            )
          ],
        )
      ],
    ).paddingAll(20);
  }
}
