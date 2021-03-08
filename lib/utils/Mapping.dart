import 'package:flutter/material.dart';

Icon getIconByString(String icon) {
  switch (icon) {
    case 'Home':
      {
        return Icon(Icons.home);
      }
      break;
    case 'Sport':
      {
        return Icon(Icons.sports_cricket);
      }
      break;
    case 'Restaurants':
      {
        return Icon(Icons.restaurant);
      }
      break;
    case 'Bars':
      {
        return Icon(Icons.sports_bar);
      }
      break;
    case 'Gifts':
      {
        return Icon(Icons.person);
      }
      break;
    case 'Pets':
      {
        return Icon(Icons.pets);
      }
      break;
    case 'Grocery':
      {
        return Icon(Icons.local_grocery_store);
      }
      break;
    case 'Stationery':
      {
        return Icon(Icons.school);
      }
      break;
    case 'Cosmetics':
      {
        return Icon(Icons.shopping_bag);
      }
      break;
    default:
      {
        return Icon(Icons.card_giftcard);
      }
  }
}
