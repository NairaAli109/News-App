// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/state.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import '../../screens/business_screen.dart';
import '../../screens/science_screen.dart';
import '../../screens/sports_screen.dart';
import '../network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  bool isDark=false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared!= null)
      {
        isDark=fromShared;
        print('++++++++++++++++++++++++++from shared $isDark');
        emit(AppChangeModeState());
      }
    else
      {
        isDark=!isDark;
        print('++++++++++++++++++++++++++is dark $isDark');
        CacheHelper.putBoolean(
          key: 'isDark',
          value: isDark,
        ).then((value) {
          emit(AppChangeModeState());
        });
      }

  }
}

class NewsCubit extends Cubit<NewsStates> {

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
  ];

  List<Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex=index;
    emit(NewsBottomNavState());
    if(index==1){
      getSportsData();
    }
    if(index==2){
      getScienceData();
    }
  }

  List<dynamic> Business=[];

  void getBusinessData(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apiKey':'9fee31f35d194344a21417f377f2f00b',
        }
    )
        .then((value) {
      Business=value.data['articles'];
      print(value.data['articles']);
      emit(NewsGetBusinessSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List<dynamic> Sports=[];

  void getSportsData(){
    emit(NewsGetSportsLoadingState());
    if (Sports.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'Sports',
            'apiKey':'9fee31f35d194344a21417f377f2f00b',
          }
      )
          .then((value) {

        Sports=value.data['articles'];
        print(value.data['articles']);
        emit(NewsGetSportsSuccessState());

      })
          .catchError((error){

        print(error.toString());
        emit(NewsGetSportsErrorState(error));

      });
    }
    else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> Science=[];

  void getScienceData(){
    emit(NewsGetScienceLoadingState());
    if(Science.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'Science',
            'apiKey':'9fee31f35d194344a21417f377f2f00b',
          }
      )
          .then((value) {
        Science=value.data['articles'];
        print(value.data['articles']);
        emit(NewsGetScienceSuccessState());
      })
          .catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error));

      });
    }
    else
      {
        emit(NewsGetSportsSuccessState());
      }

  }

  List<dynamic> search=[];

  void getSearch(String value){

    emit(NewsGetSearchLoadingState());


    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':value,
          'apiKey':'9fee31f35d194344a21417f377f2f00b',
        }
    )
        .then((value) {
      search=value.data['articles'];
      print(value.data['articles']);
      emit(NewsGetSearchSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error));

    });

  }
}

