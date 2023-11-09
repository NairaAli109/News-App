// ignore_for_file: unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/state.dart';
import '../../screens/business_screen.dart';
import '../../screens/science_screen.dart';
import '../../screens/setting.dart';
import '../../screens/sports_screen.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex= 0;

  List<BottomNavigationBarItem> bottomItems= [
    const BottomNavigationBarItem(
      icon:Icon(Icons.business),
      label: "business",
    ),
    const BottomNavigationBarItem(
      icon:Icon(Icons.sports),
      label: "sports",
    ),
    const BottomNavigationBarItem(
      icon:Icon(Icons.science),
      label: "science",
    ),
    const BottomNavigationBarItem(
      icon:Icon(Icons.settings),
      label: "settings",
    ),
  ];

  List<Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex=index;
    emit(NewsBottomNavState());
  }
}