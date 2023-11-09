import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit=NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                  "News App"
              ),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon:const Icon(Icons.search)
                ),
              ],
            ),
            body:cubit.screens[cubit.currentIndex] ,
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
