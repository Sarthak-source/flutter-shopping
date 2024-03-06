import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderShimmer extends StatelessWidget {
  final String from;
  const MyOrderShimmer({super.key, required this.from});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: from == "orderdetail" ? 100 : 300,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              /* Container(

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 10,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          SizedBox(width: 8),
                          Container(
                              height: 10,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          Container(
                              decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                        ],
      )
                    ],
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [

                    SizedBox(width: 8,),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            height: 10,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                          Container(
                              height: 10,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                          Container(
                              height: 10,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                  height: 10,
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        )



                      ],
                    ),
                  )),
*/
            ],
          )),
    );
  }
}
