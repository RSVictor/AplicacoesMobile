import 'package:appdeliverytb/ui/widgets/bag_provider.dart';
import 'package:appdeliverytb/ui/widgets/checkout/checkoutscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

AppBar getAppBar({
  required BuildContext context, String? title}){
     BagProvider bagProvider = Provider.of<BagProvider>(context);
     return AppBar(
      title:  title !=null ? Text(title): null,
      centerTitle: true,
      actions: [
        badges.Badge(
          showBadge: bagProvider.dishesOnBag.isNotEmpty, // mostra se tem itens na sacola
          position: badges.BadgePosition.bottomStart(start: 0,bottom: 0),
          badgeContent: Text(
            bagProvider.dishesOnBag.length.toString(),
            style: TextStyle(fontSize: 10,color: Colors.white),
          ),
          child: IconButton(
            onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen()));
            },
             
             icon: Icon(Icons.shopping_basket)),
        ),
        
      ],
     );
  }
  

