import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'app1_record.g.dart';

abstract class App1Record implements Built<App1Record, App1RecordBuilder> {
  static Serializer<App1Record> get serializer => _$app1RecordSerializer;

  @nullable
  String get title;

  @nullable
  String get subtitle;

  @nullable
  String get url;

  @nullable
  int get position;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(App1RecordBuilder builder) => builder
    ..title = ''
    ..subtitle = ''
    ..url = ''
    ..position = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('app1');

  static Stream<App1Record> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<App1Record> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  App1Record._();
  factory App1Record([void Function(App1RecordBuilder) updates]) = _$App1Record;

  static App1Record getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createApp1RecordData({
  String title,
  String subtitle,
  String url,
  int position,
}) =>
    serializers.toFirestore(
        App1Record.serializer,
        App1Record((a) => a
          ..title = title
          ..subtitle = subtitle
          ..url = url
          ..position = position));
