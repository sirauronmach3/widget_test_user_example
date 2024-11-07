import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_user_example/home_screen.dart';
import 'package:widget_test_user_example/user_model.dart';

void main() {
  testWidgets(
    'Displays list of users with title as names and subtitle as email',
    (tester) async {
      final users = [
        User(id: 1, name: 'Rivan', email: 'rivaan@gmail.com'),
        User(id: 2, name: 'Naman', email: 'naman@gmail.com'),
      ];

      Future<List<User>> mockFetchUsers() async {
        return Future.delayed(
          Duration(seconds: 1),
          () => users,
        );
      }

      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(
            futureUsers: mockFetchUsers(),
          ),
        ),
      );

      final progress = find.byType(CircularProgressIndicator);
      expect(progress, findsOneWidget);

      await tester.pumpAndSettle();
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);

      final listTile = find.byType(ListTile);
      expect(listTile, findsNWidgets(users.length));

      for (final user in users) {
        expect(find.text(user.name), findsOneWidget);
        expect(find.text(user.email), findsOneWidget);
      }
    },
  );
}
