import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_mvvm/view/MyHomePage.dart';
import 'package:shop_mvvm/view_model/ProductViewModel.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>(create: (context) => ProductViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop_MVVM',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
