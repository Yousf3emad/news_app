import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
  ];

  void changeIndex(int index){
    currentIndex = index;
    if(index == 0) getBusiness();
    if(index == 1) getSports();
    if(index == 2) getScience();
    emit(ChangeBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': 'us',
          'category': 'business',
          'apiKey': 'c653bc8296684e7aa85a5f1263284898'

        }
    ).then((value) {
      //print(value.data.toString());
      business = value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports(){

    emit(NewsGetSportsLoadingState());

    if(sports.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'us',
            'category': 'sports',
            'apiKey': 'c653bc8296684e7aa85a5f1263284898'

          }
      ).then((value) {
        sports = value.data['articles'];
        //print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'us',
            'category': 'science',
            'apiKey': 'c653bc8296684e7aa85a5f1263284898'

          }
      ).then((value) {
        science = value.data['articles'];
        //print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());

    }

  }


}