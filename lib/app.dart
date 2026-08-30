
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_live_test/providers/task_provider.dart';
import 'package:tm_live_test/screens/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        //home: const TaskListScreen(),
        routes: {
          '/SplashScreen' : (context) => SplashScreen(),
        },
        initialRoute: '/SplashScreen' ,
      ),
    );
  }
}