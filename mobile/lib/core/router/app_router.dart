import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/add_transaction/add_transaction_screen.dart';
import '../../screens/stats/stats_screen.dart';
import '../../features/transactions/screens/transaction_list_screen.dart';
import '../../features/transactions/screens/category_management_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomeScreen(),
    '/transactions': (context) => const TransactionListScreen(),
    '/stats': (context) => const StatsScreen(),
    '/categories': (context) => const CategoryManagementScreen(),
  };
}