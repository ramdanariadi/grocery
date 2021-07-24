import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

class WideProductCard extends StatelessWidget {
  const WideProductCard({
    Key? key,
    required this.merk,
    required this.weight,
    required this.price,
    required this.press,
    required this.imageUrl,
  }) : super(key: key);

  final String merk;
  final int weight;
  final int price;
  final VoidCallback press;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.6,
      margin: EdgeInsets.only(
          left: kDefaultPadding / 2, right: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: kNaturanWhite,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 8),
                color: kShadownColor.withOpacity(0.23),
                spreadRadius: -10,
                blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            this.imageUrl,
            width: size.width / 5,
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "${this.merk}\n",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "weight ",
                      style: TextStyle(height: 1.5, color: kBlackHint)),
                  TextSpan(
                      text: "${this.weight}g\n",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: "\$${this.price}",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "/kg",
                      style: TextStyle(height: 1.5, color: kBlackHint)),
                ])),
                SizedBox(
                  width: kDefaultPadding,
                ),
                GestureDetector(
                    onTap: this.press,
                    child: Image.asset("images/icons/plus_icon.png"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
