part of 'generated.dart';

class GetMyMovieListsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetMyMovieListsVariablesBuilder(this._dataConnect, );
  Deserializer<GetMyMovieListsData> dataDeserializer = (dynamic json)  => GetMyMovieListsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetMyMovieListsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetMyMovieListsData, void> ref() {
    
    return _dataConnect.query("GetMyMovieLists", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetMyMovieListsMovieLists {
  final String id;
  final String name;
  final String? description;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  GetMyMovieListsMovieLists.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  updatedAt = Timestamp.fromJson(json['updatedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyMovieListsMovieLists otherTyped = other as GetMyMovieListsMovieLists;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    description == otherTyped.description && 
    createdAt == otherTyped.createdAt && 
    updatedAt == otherTyped.updatedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, description.hashCode, createdAt.hashCode, updatedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    json['createdAt'] = createdAt.toJson();
    json['updatedAt'] = updatedAt.toJson();
    return json;
  }

  GetMyMovieListsMovieLists({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}

@immutable
class GetMyMovieListsData {
  final List<GetMyMovieListsMovieLists> movieLists;
  GetMyMovieListsData.fromJson(dynamic json):
  
  movieLists = (json['movieLists'] as List<dynamic>)
        .map((e) => GetMyMovieListsMovieLists.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyMovieListsData otherTyped = other as GetMyMovieListsData;
    return movieLists == otherTyped.movieLists;
    
  }
  @override
  int get hashCode => movieLists.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['movieLists'] = movieLists.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyMovieListsData({
    required this.movieLists,
  });
}

