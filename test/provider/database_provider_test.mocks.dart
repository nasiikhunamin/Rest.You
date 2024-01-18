import 'dart:async' as i3;

import 'package:mockito/mockito.dart' as i1;
import 'package:mockito/src/dummies.dart' as i8;
import 'package:sqflite/sqflite.dart' as i4;
import 'package:yourest/data/local/database/database_helper.dart' as i2;
import 'package:yourest/data/local/database/database_helper.dart';
import 'package:yourest/data/model/restaurant.dart' as i5;
import 'package:yourest/provider/db_provider.dart' as i6;
import 'package:yourest/utils/result_state.dart' as i7;

class FakeDatabaseHelper extends i1.SmartFake implements i2.DatabaseHelper {
  FakeDatabaseHelper(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks ========[DatabaseHelper].
class MockDatabaseHelper extends i1.Mock implements i2.DatabaseHelper {
  MockDatabaseHelper() {
    i1.throwOnMissingStub(this);
  }

  @override
  i3.Future<i4.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: i3.Future<i4.Database?>.value(),
      ) as i3.Future<i4.Database?>);

  @override
  i3.Future<void> addFavorite(i5.Restaurant? restaurant) => (super.noSuchMethod(
        Invocation.method(
          #addFavorite,
          [restaurant],
        ),
        returnValue: i3.Future<void>.value(),
        returnValueForMissingStub: i3.Future<void>.value(),
      ) as i3.Future<void>);

  @override
  i3.Future<List<i5.Restaurant>> getRestaurants() => (super.noSuchMethod(
        Invocation.method(
          #getRestaurants,
          [],
        ),
        returnValue: i3.Future<List<i5.Restaurant>>.value(<i5.Restaurant>[]),
      ) as i3.Future<List<i5.Restaurant>>);

  @override
  i3.Future<Map<dynamic, dynamic>> getFavoriteById(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteById,
          [id],
        ),
        returnValue:
            i3.Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}),
      ) as i3.Future<Map<dynamic, dynamic>>);

  @override
  i3.Future<void> removeFavorite(String? id) => (super.noSuchMethod(
        Invocation.method(
          #removeFavorite,
          [id],
        ),
        returnValue: i3.Future<void>.value(),
        returnValueForMissingStub: i3.Future<void>.value(),
      ) as i3.Future<void>);
}

/// A class which mocks [DatabaseProvider].
class MockDatabaseProvider extends i1.Mock implements i6.DatabaseProvider {
  MockDatabaseProvider() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.DatabaseHelper get databaseHelper => (super.noSuchMethod(
        Invocation.getter(#databaseHelper),
        returnValue: FakeDatabaseHelper(
          this,
          Invocation.getter(#databaseHelper),
        ),
      ) as i2.DatabaseHelper);

  @override
  i7.ResultState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: i7.ResultState.loading,
      ) as i7.ResultState);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: i8.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  List<i5.Restaurant> get favorites => (super.noSuchMethod(
        Invocation.getter(#favorites),
        returnValue: <i5.Restaurant>[],
      ) as List<i5.Restaurant>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void addFavorite(i5.Restaurant? restaurant) => super.noSuchMethod(
        Invocation.method(
          #addFavorite,
          [restaurant],
        ),
        returnValueForMissingStub: null,
      );

  @override
  i3.Future<bool> isFavorited(String? id) => (super.noSuchMethod(
        Invocation.method(
          #isFavorited,
          [id],
        ),
        returnValue: i3.Future<bool>.value(false),
      ) as i3.Future<bool>);

  @override
  void removeFavorited(String? id) => super.noSuchMethod(
        Invocation.method(
          #removeFavorited,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
