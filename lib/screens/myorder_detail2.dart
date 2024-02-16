import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import 'myorders_screen.dart';

class MyOrderDetail2 extends StatefulWidget {
  final OrdersList orderdetail;
  MyOrderDetail2({
    required this.orderdetail
  });

  @override
  State<MyOrderDetail2> createState() => _MyOrderDetail2State();
}

class _MyOrderDetail2State extends State<MyOrderDetail2> {
  @override
  Widget build(BuildContext context) {

    final List<ODdatas> oddatas = [
      ODdatas(
        image: "http://www.dilicia.in/plugins/parallax2/images/product/full%20cream%20milk.png",
        title: "Full Cream Milk",
        qty: "2",
        price: "20",
        total: "100",
        gst: "2",
        sgst: "2"
      ),ODdatas(
        image: "http://www.dilicia.in/images/product/Toned%20milk.png",
        title: "Tonned Milk",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"
      ),ODdatas(
        image: "http://www.dilicia.in/images/product/Doubel%20toned%20milk.png",
        title: "Double Tonned Milk",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"
      ),ODdatas(
        image: "http://www.dilicia.in/images/product/standerd%20milk.png",
        title: "Standardised Milk",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"
      ),ODdatas(
        image: "http://www.dilicia.in/images/product/Ghee.png",
        title: "Buffalo Ghee",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"
      ),ODdatas(
        image: "http://www.dilicia.in/images/product/Cow%20Ghee.png",
        title: "Cow Ghee",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"
      ),
    ];

    var deviceheight = MediaQuery.of(context).size.height;
    var devicewidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar('Order Details', []),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            Container(
                width: devicewidth,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      //height: 26,
                      color: Colors.teal.shade50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex:1,
                                child: Row(
                                  children: [
                                    Container(
                                      // color: Colors.green,
                                        child: Text("#", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                          color: kTextColorAccent,
                                        ))),
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            // color: Colors.yellow,
                                            child: Text(widget.orderdetail.orderid, style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis),),
                                        )),
                                  ],
                                )),
                            Row(
                              children: [
                                Text(widget.orderdetail.date, style: const TextStyle(
                                    color: Colors.black, fontSize: 12),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                      thickness: 0.3,
                      height: 1,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.green,
                                    child: Text("Address:", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      color: kTextColorAccent,
                                    ))),
                                Container(
                                  //  color: Colors.yellow,
                                    child: Text(widget.orderdetail.address, style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              //color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(("₹ ${widget.orderdetail.amount}")),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: oddatas.length,
                  itemBuilder: (context,index){
                    return  OrderTile(context,oddatas[index]);
                  }),
            ),

          ],
        ),
        ));
  }

  Container OrderTile(BuildContext context, ODdatas oddata) {
    return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                 // color: Colors.red.shade50,
                  child: Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: Container(
                            height:80,
                            width: 80,
                          //  color: Colors.red,
                           // child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYPeQAtK8frgCvtzkLgzv513bMPi7yij6peQ&usqp=CAU",height: 50,width: 50,))
                            child: Image.network(oddata.image,height: 50,width: 50,)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),

                  Expanded(
                    flex:1,
                      child:
                      Text(
                          oddata.title,
                          style:Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        color: kTextBlackColor,
                        ),
                        maxLines: 3,
                  )
                  ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex:1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ODtile("Qty:",oddata.qty),
                            ODtile("Price:",oddata.price),
                          ],
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ODtile("Total:",oddata.total),
                            ODtile("GST:",oddata.gst),
                          ],
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ODtile("SGST:",oddata.sgst),
                            ODtile("",""),
                          ],
                        ),
                      ),






                /*      Expanded(
                          flex: 1,child: ODtile("Price","20")),
                      Expanded(
                          flex: 1,child: ODtile("Total","100")),
                      Expanded(
                          flex: 1,child: ODtile("GST","2")),
                      Expanded(
                          flex: 1,child: ODtile("SGST","2")),*/
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Text("Total:",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                color: kTextBlackColor,
                              )),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Text("₹ ${oddata.total}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                color: kTextBlackColor,
                              ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Container ODtile(String title,String subtitle) {
    return Container(
     // color: Colors.red.shade50,
      child: Row(
        children: [
          Expanded(
            flex:1,
            child: Text(title, style:Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              color: kTextBlackColor,
            )),
          ),
          SizedBox(width: 6),
          Expanded(
            flex:1,
            child: Text(subtitle,
              style:Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kTextBlackColor,
            )),
          ),
        ],
      ),
    );
  }
}

class ODdatas {
 final String title;
 final String image;
 final String qty;
 final String price;
 final String total;
 final String gst;
 final String sgst;
  ODdatas({
    required this.title,
    required this.image,
    required this.qty,
    required this.price,
    required this.total,
    required this.gst,
    required this.sgst
});
}