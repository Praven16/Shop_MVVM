import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_mvvm/view/CartPage.dart';
import 'package:shop_mvvm/view_model/ProductViewModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var productViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productViewModel = Provider.of<ProductViewModel>(context,listen:false);
    productViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text("Shop MVVM",style: TextStyle(color: Colors.blue),),
              actions: [
                Consumer<ProductViewModel>(
                    builder: (context,data1,child){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[

                              Icon(Icons.shopping_cart,color: Colors.blue,),
                              Text(data1.countCart.toString(),style: TextStyle(color: Colors.blue),)

                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
            body: Consumer<ProductViewModel>(builder: (context,data,child){
              return data.isLoading?
              Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
                  : ListView.builder(
                  itemCount: data.productLists.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(left: 5,bottom: 0),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(data.productLists[index].image!),
                                      fit: BoxFit.cover,
                                  ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 28.0,right: 10.0),
                            child: Container(
                                child: Row(
                                  children: <Widget>[

                                    Expanded(child: Text(data.productLists[index].title!,style: TextStyle(fontSize: 20),)),

                                    Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        child: Text(data.productLists[index].ratingModel!.rate!.toString(),style: TextStyle(fontSize: 16),)),

                                  ],
                                )
                            ),
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text("Rs. "+data.productLists[index].price!.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                              ),
                              Spacer(),
                              data.cartLists.contains(data.productLists[index])
                                  ?
                              ElevatedButton(
                                onPressed: (){
                                  productViewModel.removeCart(data.productLists[index]);
                                }, child: const Icon(Icons.add),
                              ):
                              ElevatedButton(
                                onPressed: (){
                                  productViewModel.addCart(data.productLists[index]);
                                }, child: const Icon(Icons.add),
                              ),
                            ],
                          ),



                        ],
                      ),
                    );
                  }
              );
            })
        )
    );
  }
}
