import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_mvvm/view_model/ProductViewModel.dart';

class CartBottomNavbar extends StatefulWidget {
  const CartBottomNavbar({Key? key}) : super(key: key);

  @override
  State<CartBottomNavbar> createState() => _CartBottomNavbarState();
}

class _CartBottomNavbarState extends State<CartBottomNavbar> {
  var productViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productViewModel = Provider.of<ProductViewModel>(context,listen:false);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<ProductViewModel>(builder: (context,data1,child){
              return Row(
                children: <Widget>[

                  Expanded(child: Text("My Cart, (${data1.countCart.toString()})", style: TextStyle(color: Color(0xff330433),fontSize: 18,fontWeight: FontWeight.bold),)),
                ],
              );
            }),

            Consumer<ProductViewModel>(
              builder: (context,data1,child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "Total:",
                      style: TextStyle(
                        color: Color(0xFF330433),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(data1.totalPrice.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF330413),
                      ),
                    )
                  ],
                );
              }
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF330413),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Check Out",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
