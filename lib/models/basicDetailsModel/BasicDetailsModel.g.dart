// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BasicDetailsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BasicDetailsModelImpl _$$BasicDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BasicDetailsModelImpl(
      profileImage: json['profileImage'] as String,
      name: json['name'] as String,
      birthday: json['birthday'] as String,
      occupation: json['occupation'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
      skinType: json['skinType'] as String,
      height: json['height'] as String,
    );

Map<String, dynamic> _$$BasicDetailsModelImplToJson(
        _$BasicDetailsModelImpl instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'name': instance.name,
      'birthday': instance.birthday,
      'occupation': instance.occupation,
      'address': instance.address,
      'gender': instance.gender,
      'age': instance.age,
      'skinType': instance.skinType,
      'height': instance.height,
    };
