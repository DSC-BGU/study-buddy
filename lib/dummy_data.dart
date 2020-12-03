import 'package:flutter/material.dart';

import './models/category.dart';
import './models/store.dart';
import './models/Cupon.dart';

const DUMMY_CATEGORIES = const [
  Category(
    id: 'c1',
    title: 'Restaurants',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Bars',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Grocery',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'Take Away',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Office Supplies',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    title: 'Clothes',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Attractions',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Sport',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'Mobile',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Pets',
    color: Colors.brown,
  ),
  Category(
    id: 'c11',
    title: 'Department Store',
    color: Colors.cyan,
  ),
];

const DUMMY_STORES = const [
  Store(
    id: 's1',
    name: 'Agadir',
    adress: 'Derech Metzada 17',
    imageURL:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    description: 'Agadir resturant. Fast Food',
    categories: [
      'c1',
      'c4',
    ],
  ),
  Store(
    id: 's2',
    name: 'MiniMarket Shani',
    adress: 'Shlomo Hamelech 9',
    imageURL: '',
    description: 'Mini Market. Open 24/7',
    categories: [
      'c3',
    ],
  ),
  Store(
    id: 's3',
    name: 'Alalof',
    adress: 'Yitskhak Avinu St 1',
    imageURL: '',
    description: 'Department store',
    categories: [
      'c11',
      'c5',
    ],
  ),
  Store(
    id: 's4',
    name: 'Rosa Bar',
    adress: 'Rabbi Akiva St, Be\'er Sheva',
    imageURL: '',
    description: '',
    categories: [
      'c1',
      'c2',
    ],
  ),
  Store(
    id: 's5',
    name: 'Mileva',
    adress: 'Shlomo ha-Melekh St 2, Be\'er Sheva',
    imageURL:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPwdAdxASgS4itLjUhtbYT6ieNJF3PoVrmXw&usqp=CAU',
    description: '',
    categories: [
      'c1',
      'c2',
    ],
  ),
  Store(
    id: 's6',
    name: 'Hayarkanya Sheli',
    adress: 'Haim Nachman Bialik St 26, Be\'er Sheva',
    imageURL: '',
    description: 'Fruits & Vegetables',
    categories: [
      'c3',
    ],
  ),
  Store(
    id: 's7',
    name: 'Mega pet',
    adress: 'Yosef ha-Bursekai St 1, Be\'er Sheva',
    imageURL: '',
    description: 'Everything for your furry friend',
    categories: [
      'c10',
    ],
  ),
  Store(
    id: 's8',
    name: 'Lider',
    adress: 'Ha-Tikva St 10, Be\'er Sheva',
    imageURL:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    description: 'Clothes for Childrens',
    categories: [
      'c6',
    ],
  ),
  Store(
    id: 's9',
    name: 'ER Cellular',
    adress: 'Heil Handasa St, Be\'er Sheva',
    imageURL: '',
    description: 'Fix yout phone',
    categories: [
      'c9',
    ],
  ),
  Store(
    id: 's10',
    name: 'Mega Sports',
    adress: 'ONE, Yitshak Nafha St 25, Be\'er Sheva',
    imageURL: '',
    description: 'Buy equipment',
    categories: [
      'c6',
      'c8',
    ],
  ),
  Store(
    id: 's11',
    name: 'Laser City',
    adress: 'Heil Handasa St 1, Be\'er Sheva',
    imageURL:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRffQGDtjFiwZCFIACHOZfSKXFEjNkNbHfTfw&usqp=CAU',
    description: 'Pew pew!',
    categories: [
      'c7',
    ],
  ),
  Store(
    id: 's12',
    name: 'Cinema City',
    adress: 'Hita St 1, Be\'er Sheva',
    imageURL: '',
    description: 'Cinema',
    categories: [
      'c7',
    ],
  ),
  Store(
    id: 's13',
    name: 'lee office',
    adress: 'Yosef Ben Matityahu St 76, Be\'er Sheva',
    imageURL: '',
    description: '',
    categories: [
      'c5',
      'c11',
    ],
  ),
  Store(
    id: 's14',
    name: 'Studio Positive',
    adress: 'University',
    imageURL: '',
    description: '',
    categories: [
      'c8',
    ],
  ),
  Store(
    id: 's15',
    name: 'Zoostore',
    adress: 'Avraham Avinu St 3, Be\'er Sheva',
    imageURL: '',
    description: '',
    categories: [
      'c9',
    ],
  ),
];

const DUMMY_CUPONS = const [
  Cupon(
    id: 'p1',
    storeId: 's1',
    description: '1+1 on all Hamburgers',
    imageURL:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    points: 70,
    categories: [
      'c1',
      'c2',
    ],
  ),
  Cupon(
    id: 'p2',
    storeId: 's4',
    description: '20% of all beers',
    imageURL:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHirzyvm--Vo6ejQ6ImeIYryCtglW8t5pnZg&usqp=CAU',
    points: 30,
    categories: [
      'c1',
      'c2',
    ],
  ),
  Cupon(
    id: 'p3',
    storeId: 's14',
    description: '10% On 10 trainings',
    imageURL:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFWSVHw_DzO9BVOOHOOMnbralpg1561yN_hQ&usqp=CAU',
    points: 40,
    categories: [
      'c8',
    ],
  ),
  Cupon(
    id: 'p4',
    storeId: 's5',
    description: '20% of all beers',
    imageURL:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEadsPmF6WnoFMun4Gfy-TGGlzHwwW98mBzA&usqp=CAU',
    points: 30,
    categories: [
      'c1',
      'c2',
    ],
  ),
  Cupon(
    id: 'p5',
    storeId: 's12',
    description: '30% on Disney movies',
    imageURL:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE40RUns5KIvAOBag57Nd6Dz2oferHxB_kbg&usqp=CAU',
    points: 30,
    categories: [
      'c7',
    ],
  ),
];
