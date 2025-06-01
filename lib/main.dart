import 'package:flutter/material.dart';
import 'package:mybooks/feature/books/presentation/bloc/bloc/book_bloc.dart';
import 'package:mybooks/feature/books/presentation/pages/book_page.dart';
import 'package:mybooks/feature/books/presentation/widgets/add_or_edit.dart';
import 'package:mybooks/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<BookBloc>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: BookPage(),
      ),
    );
  }
}
