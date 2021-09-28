//Dart libraries
import 'dart:math';

//Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//User Exception
import '../exceptions/user_exception.dart';

//Error Page
import '../pages/error_page.dart';

//Providers
import '../providers/providers.dart';

class MyHomePage extends ConsumerWidget {
  //Declare a random private variable
  final _random = Random();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Users'),
      ),
      body: Center(
        //Watching the usersFutureProvider
        child: watch(usersFutureProvider).when(
          error: (e, s) {
            if (e is UserException) {
              return ErrorPage(message: e.message);
            }
            return ErrorPage(
              message: "Oops, something unexpected happened",
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          data: (users) {
            //Test print user fetched by provider
            print("Users in main ${users[0]}");
            //RefreshIndicator enables us to pull the screen down to make another call to the API
            return RefreshIndicator(
              onRefresh: () {
                return context.refresh(usersFutureProvider);
              },
              child: ListView.builder(
                //Limit items fetched to 5
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: CircleAvatar(
                          //Randomize the background colors of the circle avatar
                          backgroundColor: Colors.primaries[
                                  _random.nextInt(Colors.primaries.length)]
                              [_random.nextInt(9) * 100],
                          //Get the first character of the name i.e the letter at index 0
                          child: Text(users[index].name![0].toString()),
                        ),
                        title: Text(users[index].name.toString()));
                  }),
            );
          },
        ),
      ),
    );
  }
}
