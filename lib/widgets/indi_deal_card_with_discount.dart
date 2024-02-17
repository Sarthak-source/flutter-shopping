import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/discount_text.dart';

class ProductCardWithDiscount extends StatelessWidget {
  final bool? isLeft;
  final bool? isSelected;
  final  Function()? addHandler;

  const ProductCardWithDiscount(
      {super.key, this.isLeft, this.isSelected, this.addHandler});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isLeft! ? getProportionateScreenWidth(16.0) : 0,
        right: isLeft! ? 0 : getProportionateScreenWidth(16.0),
      ),
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        decoration: BoxDecoration(
          color: isSelected! ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(
              8,
            ),
          ),
          boxShadow: [
            isSelected!
                ? BoxShadow(
                    color: kShadowColor,
                    offset: Offset(
                      getProportionateScreenWidth(24),
                      getProportionateScreenWidth(40),
                    ),
                    blurRadius: 80,
                  )
                : const BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kGreyShade5,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(8.0),
                  ),
                  const DiscoutText(),
                  const Spacer(),
                  Text(
                    'Dragon Fruit',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '200gr',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColorAccent,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Divider.png'),
                          ),
                        ),
                        child: const Text(
                          '\$90',
                          style: TextStyle(
                            color: kTextColorAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(8.0),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '\$45',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: addHandler,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: kPrimaryBlue,
                        constraints: BoxConstraints.tightFor(
                          width: getProportionateScreenWidth(
                            40,
                          ),
                          height: getProportionateScreenWidth(
                            40,
                          ),
                        ),
                        elevation: 0,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
