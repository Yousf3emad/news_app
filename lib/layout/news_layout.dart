import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_states.dart';

import '../cubit/app_cubit.dart';

class NewsLayout extends StatelessWidget{

  var scaffoldKey = GlobalKey<ScaffoldState>();
  NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    //NewsCubit cubit = BlocProvider.of(context);
        return BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(),
          child: BlocConsumer<NewsCubit,NewsStates>(
            listener: (context, state){},
            builder: (context, state){
              return Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  title: const Text('News App'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search,
                        size: 30,
                      ),
                      onPressed: (){},
                    ),
                    const SizedBox(width: 12.0,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        icon: const Icon(Icons.brightness_4_outlined,
                        ),
                        onPressed: (){
                          AppCubit.get(context).changeAppMode();
                        },
                      ),
                    ),
                  ],
                ),
                body: NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,

                  selectedItemColor: Colors.deepOrange,
                  currentIndex: NewsCubit.get(context).currentIndex,
                  onTap: (index) {
                    NewsCubit.get(context).changeIndex(index);
                  },
                  items: NewsCubit.get(context).bottomNavBarItems,
                ),
              );
            },
          ),
        );
      }
  }
