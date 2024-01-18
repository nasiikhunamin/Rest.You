import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yourest/data/local/database/database_helper.dart';
import 'package:yourest/data/model/restaurant.dart';
import 'package:yourest/provider/db_provider.dart';
import 'package:yourest/utils/result_state.dart';

import 'database_provider_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late DatabaseProvider databaseProvider;
  late Restaurant testRestaurant;

  setUp(() {
    testRestaurant = Restaurant(
        id: "id-123",
        name: "restaurant-123",
        description: "Lorem Ipsum Dicoding",
        pictUrl: "24",
        categories: [],
        city: "Bandung",
        rating: 5.0);
    mockDatabaseHelper = MockDatabaseHelper();
    when(mockDatabaseHelper.getRestaurants())
        .thenAnswer((_) async => [testRestaurant]);
    databaseProvider = DatabaseProvider(databaseHelper: mockDatabaseHelper);
  });

  group("addFavorite", () {
    test(
        "Add Favorite Should hasData and Have Return Same Amount of Restaurant",
        () async {
      final expectedFavorites = [
        Restaurant(
            id: "id-123",
            name: "restaurant-123",
            description: "Lorem Ipsum Dicoding",
            pictUrl: "24",
            categories: [],
            city: "Bandung",
            rating: 5.0)
      ];
      when(mockDatabaseHelper.addFavorite(testRestaurant))
          .thenAnswer((_) async {});
      when(mockDatabaseHelper.getRestaurants())
          .thenAnswer((_) async => <Restaurant>[]);
      databaseProvider.addFavorite(testRestaurant);
      verify(mockDatabaseHelper.addFavorite(testRestaurant)).called(1);
      verify(mockDatabaseHelper.getRestaurants()).called(1);
      expect(
          databaseProvider.favorites.length, equals(expectedFavorites.length));
      expect(databaseProvider.state, ResultState.hasData);
    });
  });

  group("getFavorite", () {
    test(
        "Get Favorite by id Should hasData and Have Return Same Amount of Restaurant",
        () async {
      when(mockDatabaseHelper.addFavorite(testRestaurant))
          .thenAnswer((_) async {});
      when(mockDatabaseHelper.getRestaurants())
          .thenAnswer((_) async => <Restaurant>[]);
      when(mockDatabaseHelper.getFavoriteById(testRestaurant.id))
          .thenAnswer((_) async => {"id": testRestaurant.id});
      databaseProvider.addFavorite(testRestaurant);
      final isFavorited = await databaseProvider.isFavorited(testRestaurant.id);
      verify(mockDatabaseHelper.getFavoriteById(testRestaurant.id)).called(1);
      expect(isFavorited, true);
      expect(databaseProvider.state, ResultState.hasData);
    });
  });

  group("removeFavorite", () {
    test(
        "Remove Favorited Should Remove The Restaurant Update State to hasData",
        () async {
      when(mockDatabaseHelper.addFavorite(testRestaurant))
          .thenAnswer((_) async {});
      when(mockDatabaseHelper.getRestaurants())
          .thenAnswer((_) async => <Restaurant>[]);
      when(mockDatabaseHelper.getFavoriteById(testRestaurant.id))
          .thenAnswer((_) async => {"id": testRestaurant.id});
      databaseProvider.addFavorite(testRestaurant);
      databaseProvider.removeFavorited(testRestaurant.id);
      verify(mockDatabaseHelper.removeFavorite(testRestaurant.id)).called(1);
      verify(mockDatabaseHelper.getRestaurants()).called(1);
      expect(databaseProvider.state, ResultState.hasData);
    });
  });
}
