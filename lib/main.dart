import 'services/api_service.dart';
import 'package:flutter/material.dart';
import 'blocs/time_blocs/time_cubit.dart';
import 'blocs/post_blocs/post_cubit.dart';
import 'repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pratical_bloc_demo/Screens/home_screen.dart';
import 'package:pratical_bloc_demo/utils/local_storage_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize services
    final apiService = ApiService();
    final localStorageService = LocalStorageService();

    // Initialize the PostRepository with services
    final postRepository = PostRepository(
      apiService: apiService,
      localStorageService: localStorageService,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TimerCubit()), // Provide TimerCubit
        BlocProvider(
            create: (context) =>
                PostCubit(postRepository)), // Provide PostCubit
      ],
      child: MaterialApp(
        title: 'Post App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
