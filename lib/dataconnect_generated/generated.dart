library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_public_movie_list.dart';

part 'get_public_movie_lists.dart';

part 'create_user_movie_list.dart';

part 'get_my_movie_lists.dart';







class ExampleConnector {
  
  
  CreatePublicMovieListVariablesBuilder createPublicMovieList ({required String name, }) {
    return CreatePublicMovieListVariablesBuilder(dataConnect, name: name,);
  }
  
  
  GetPublicMovieListsVariablesBuilder getPublicMovieLists () {
    return GetPublicMovieListsVariablesBuilder(dataConnect, );
  }
  
  
  CreateUserMovieListVariablesBuilder createUserMovieList ({required String name, }) {
    return CreateUserMovieListVariablesBuilder(dataConnect, name: name,);
  }
  
  
  GetMyMovieListsVariablesBuilder getMyMovieLists () {
    return GetMyMovieListsVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'example',
    'app',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
