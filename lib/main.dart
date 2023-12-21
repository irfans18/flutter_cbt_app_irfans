import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app_irfans/data/datasources/exam_remote_datasource.dart';
import 'package:flutter_cbt_app_irfans/presentation/quiz/bloc/create_exam/create_exam_bloc.dart';
import 'package:flutter_cbt_app_irfans/presentation/quiz/bloc/exam_by_category/exam_by_category_bloc.dart';

import 'core/constants/colors.dart';
import 'data/datasources/auth_local_datasource.dart';
import 'data/datasources/content_remote_datasource.dart';
import 'data/datasources/course_remote_datasource.dart';
import 'data/datasources/onboarding_local_datasource.dart';
import 'data/models/responses/auth_response_model.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/logout/logout_bloc.dart';
import 'presentation/auth/bloc/register/register_bloc.dart';
import 'presentation/auth/pages/login_page.dart';
import 'presentation/course/bloc/bloc/course_bloc.dart';
import 'presentation/home/bloc/content/content_bloc.dart';
import 'presentation/home/pages/dashboard_page.dart';
import 'presentation/onboarding/pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ContentBloc(ContentRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => CourseBloc(CourseRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => ExamByCategoryBloc(ExamRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => CreateExamBloc(ExamRemoteDataSource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.light,
        ),
        home: FutureBuilder<AuthResponseModel>(
          future: AuthLocalDataSource().getAuthData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const DashboardPage();
            } else {
              return FutureBuilder<bool>(
                future: OnboardingLocalDatasource().getOnboadingPassed(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!
                        ? const LoginPage()
                        : const OnboardingPage();
                  } else {
                    return const OnboardingPage();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
