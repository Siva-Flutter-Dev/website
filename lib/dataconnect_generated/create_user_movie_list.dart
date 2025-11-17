part of 'generated.dart';

class CreateUserMovieListVariablesBuilder {
  String name;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateUserMovieListVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  CreateUserMovieListVariablesBuilder(this._dataConnect, {required  this.name,});
  Deserializer<CreateUserMovieListData> dataDeserializer = (dynamic json)  => CreateUserMovieListData.fromJson(jsonDecode(json));
  Serializer<CreateUserMovieListVariables> varsSerializer = (CreateUserMovieListVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateUserMovieListData, CreateUserMovieListVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateUserMovieListData, CreateUserMovieListVariables> ref() {
    CreateUserMovieListVariables vars= CreateUserMovieListVariables(name: name,description: _description,);
    return _dataConnect.mutation("CreateUserMovieList", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateUserMovieListMovieListInsert {
  final String id;
  CreateUserMovieListMovieListInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserMovieListMovieListInsert otherTyped = other as CreateUserMovieListMovieListInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateUserMovieListMovieListInsert({
    required this.id,
  });
}

@immutable
class CreateUserMovieListData {
  final CreateUserMovieListMovieListInsert movieList_insert;
  CreateUserMovieListData.fromJson(dynamic json):
  
  movieList_insert = CreateUserMovieListMovieListInsert.fromJson(json['movieList_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserMovieListData otherTyped = other as CreateUserMovieListData;
    return movieList_insert == otherTyped.movieList_insert;
    
  }
  @override
  int get hashCode => movieList_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['movieList_insert'] = movieList_insert.toJson();
    return json;
  }

  CreateUserMovieListData({
    required this.movieList_insert,
  });
}

@immutable
class CreateUserMovieListVariables {
  final String name;
  late final Optional<String>description;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateUserMovieListVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']) {
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserMovieListVariables otherTyped = other as CreateUserMovieListVariables;
    return name == otherTyped.name && 
    description == otherTyped.description;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, description.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    return json;
  }

  CreateUserMovieListVariables({
    required this.name,
    required this.description,
  });
}

