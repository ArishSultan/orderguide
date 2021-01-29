// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DistributorTableData extends DataClass
    implements Insertable<DistributorTableData> {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String salesmanName;
  DistributorTableData(
      {@required this.id,
      @required this.name,
      @required this.phone,
      @required this.email,
      @required this.salesmanName});
  factory DistributorTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return DistributorTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      salesmanName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}salesman_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || salesmanName != null) {
      map['salesman_name'] = Variable<String>(salesmanName);
    }
    return map;
  }

  DistributorTableCompanion toCompanion(bool nullToAbsent) {
    return DistributorTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      salesmanName: salesmanName == null && nullToAbsent
          ? const Value.absent()
          : Value(salesmanName),
    );
  }

  factory DistributorTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DistributorTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
      salesmanName: serializer.fromJson<String>(json['salesmanName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
      'salesmanName': serializer.toJson<String>(salesmanName),
    };
  }

  DistributorTableData copyWith(
          {int id,
          String name,
          String phone,
          String email,
          String salesmanName}) =>
      DistributorTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        salesmanName: salesmanName ?? this.salesmanName,
      );
  @override
  String toString() {
    return (StringBuffer('DistributorTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('salesmanName: $salesmanName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              phone.hashCode, $mrjc(email.hashCode, salesmanName.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DistributorTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.salesmanName == this.salesmanName);
}

class DistributorTableCompanion extends UpdateCompanion<DistributorTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> email;
  final Value<String> salesmanName;
  const DistributorTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.salesmanName = const Value.absent(),
  });
  DistributorTableCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String phone,
    @required String email,
    @required String salesmanName,
  })  : name = Value(name),
        phone = Value(phone),
        email = Value(email),
        salesmanName = Value(salesmanName);
  static Insertable<DistributorTableData> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> phone,
    Expression<String> email,
    Expression<String> salesmanName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (salesmanName != null) 'salesman_name': salesmanName,
    });
  }

  DistributorTableCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> phone,
      Value<String> email,
      Value<String> salesmanName}) {
    return DistributorTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      salesmanName: salesmanName ?? this.salesmanName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (salesmanName.present) {
      map['salesman_name'] = Variable<String>(salesmanName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DistributorTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('salesmanName: $salesmanName')
          ..write(')'))
        .toString();
  }
}

class $DistributorTableTable extends DistributorTable
    with TableInfo<$DistributorTableTable, DistributorTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $DistributorTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  GeneratedTextColumn _phone;
  @override
  GeneratedTextColumn get phone => _phone ??= _constructPhone();
  GeneratedTextColumn _constructPhone() {
    return GeneratedTextColumn(
      'phone',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _salesmanNameMeta =
      const VerificationMeta('salesmanName');
  GeneratedTextColumn _salesmanName;
  @override
  GeneratedTextColumn get salesmanName =>
      _salesmanName ??= _constructSalesmanName();
  GeneratedTextColumn _constructSalesmanName() {
    return GeneratedTextColumn(
      'salesman_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, phone, email, salesmanName];
  @override
  $DistributorTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'distributors';
  @override
  final String actualTableName = 'distributors';
  @override
  VerificationContext validateIntegrity(
      Insertable<DistributorTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone'], _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('salesman_name')) {
      context.handle(
          _salesmanNameMeta,
          salesmanName.isAcceptableOrUnknown(
              data['salesman_name'], _salesmanNameMeta));
    } else if (isInserting) {
      context.missing(_salesmanNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DistributorTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DistributorTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DistributorTableTable createAlias(String alias) {
    return $DistributorTableTable(_db, alias);
  }
}

class ItemTableData extends DataClass implements Insertable<ItemTableData> {
  final int id;
  final String name;
  ItemTableData({@required this.id, @required this.name});
  factory ItemTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ItemTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  ItemTableCompanion toCompanion(bool nullToAbsent) {
    return ItemTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory ItemTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ItemTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ItemTableData copyWith({int id, String name}) => ItemTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ItemTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ItemTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class ItemTableCompanion extends UpdateCompanion<ItemTableData> {
  final Value<int> id;
  final Value<String> name;
  const ItemTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ItemTableCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  static Insertable<ItemTableData> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ItemTableCompanion copyWith({Value<int> id, Value<String> name}) {
    return ItemTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ItemTableTable extends ItemTable
    with TableInfo<$ItemTableTable, ItemTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ItemTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $ItemTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'items';
  @override
  final String actualTableName = 'items';
  @override
  VerificationContext validateIntegrity(Insertable<ItemTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ItemTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ItemTableTable createAlias(String alias) {
    return $ItemTableTable(_db, alias);
  }
}

class ItemDistributionTableData extends DataClass
    implements Insertable<ItemDistributionTableData> {
  final int id;
  final int item;
  final int distributor;
  final double price;
  ItemDistributionTableData(
      {@required this.id,
      @required this.item,
      @required this.distributor,
      @required this.price});
  factory ItemDistributionTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return ItemDistributionTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      item: intType.mapFromDatabaseResponse(data['${effectivePrefix}item']),
      distributor: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}distributor']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<int>(item);
    }
    if (!nullToAbsent || distributor != null) {
      map['distributor'] = Variable<int>(distributor);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    return map;
  }

  ItemDistributionTableCompanion toCompanion(bool nullToAbsent) {
    return ItemDistributionTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
      distributor: distributor == null && nullToAbsent
          ? const Value.absent()
          : Value(distributor),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  factory ItemDistributionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ItemDistributionTableData(
      id: serializer.fromJson<int>(json['id']),
      item: serializer.fromJson<int>(json['item']),
      distributor: serializer.fromJson<int>(json['distributor']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'item': serializer.toJson<int>(item),
      'distributor': serializer.toJson<int>(distributor),
      'price': serializer.toJson<double>(price),
    };
  }

  ItemDistributionTableData copyWith(
          {int id, int item, int distributor, double price}) =>
      ItemDistributionTableData(
        id: id ?? this.id,
        item: item ?? this.item,
        distributor: distributor ?? this.distributor,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('ItemDistributionTableData(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('distributor: $distributor, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(item.hashCode, $mrjc(distributor.hashCode, price.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ItemDistributionTableData &&
          other.id == this.id &&
          other.item == this.item &&
          other.distributor == this.distributor &&
          other.price == this.price);
}

class ItemDistributionTableCompanion
    extends UpdateCompanion<ItemDistributionTableData> {
  final Value<int> id;
  final Value<int> item;
  final Value<int> distributor;
  final Value<double> price;
  const ItemDistributionTableCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.distributor = const Value.absent(),
    this.price = const Value.absent(),
  });
  ItemDistributionTableCompanion.insert({
    this.id = const Value.absent(),
    @required int item,
    @required int distributor,
    @required double price,
  })  : item = Value(item),
        distributor = Value(distributor),
        price = Value(price);
  static Insertable<ItemDistributionTableData> custom({
    Expression<int> id,
    Expression<int> item,
    Expression<int> distributor,
    Expression<double> price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (item != null) 'item': item,
      if (distributor != null) 'distributor': distributor,
      if (price != null) 'price': price,
    });
  }

  ItemDistributionTableCompanion copyWith(
      {Value<int> id,
      Value<int> item,
      Value<int> distributor,
      Value<double> price}) {
    return ItemDistributionTableCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      distributor: distributor ?? this.distributor,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (distributor.present) {
      map['distributor'] = Variable<int>(distributor.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemDistributionTableCompanion(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('distributor: $distributor, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $ItemDistributionTableTable extends ItemDistributionTable
    with TableInfo<$ItemDistributionTableTable, ItemDistributionTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ItemDistributionTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _itemMeta = const VerificationMeta('item');
  GeneratedIntColumn _item;
  @override
  GeneratedIntColumn get item => _item ??= _constructItem();
  GeneratedIntColumn _constructItem() {
    return GeneratedIntColumn('item', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES items(id)');
  }

  final VerificationMeta _distributorMeta =
      const VerificationMeta('distributor');
  GeneratedIntColumn _distributor;
  @override
  GeneratedIntColumn get distributor =>
      _distributor ??= _constructDistributor();
  GeneratedIntColumn _constructDistributor() {
    return GeneratedIntColumn('distributor', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES distributors(id)');
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, item, distributor, price];
  @override
  $ItemDistributionTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'item_distributions';
  @override
  final String actualTableName = 'item_distributions';
  @override
  VerificationContext validateIntegrity(
      Insertable<ItemDistributionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item'], _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('distributor')) {
      context.handle(
          _distributorMeta,
          distributor.isAcceptableOrUnknown(
              data['distributor'], _distributorMeta));
    } else if (isInserting) {
      context.missing(_distributorMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemDistributionTableData map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ItemDistributionTableData.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  $ItemDistributionTableTable createAlias(String alias) {
    return $ItemDistributionTableTable(_db, alias);
  }
}

class OrdersTableData extends DataClass implements Insertable<OrdersTableData> {
  final int id;
  final int count;
  final bool completed;
  final int distributor;
  final double price;
  final DateTime createdAt;
  OrdersTableData(
      {@required this.id,
      @required this.count,
      @required this.completed,
      @required this.distributor,
      @required this.price,
      @required this.createdAt});
  factory OrdersTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return OrdersTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      count: intType.mapFromDatabaseResponse(data['${effectivePrefix}count']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
      distributor: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}distributor']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    if (!nullToAbsent || distributor != null) {
      map['distributor'] = Variable<int>(distributor);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  OrdersTableCompanion toCompanion(bool nullToAbsent) {
    return OrdersTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      distributor: distributor == null && nullToAbsent
          ? const Value.absent()
          : Value(distributor),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory OrdersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return OrdersTableData(
      id: serializer.fromJson<int>(json['id']),
      count: serializer.fromJson<int>(json['count']),
      completed: serializer.fromJson<bool>(json['completed']),
      distributor: serializer.fromJson<int>(json['distributor']),
      price: serializer.fromJson<double>(json['price']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'count': serializer.toJson<int>(count),
      'completed': serializer.toJson<bool>(completed),
      'distributor': serializer.toJson<int>(distributor),
      'price': serializer.toJson<double>(price),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OrdersTableData copyWith(
          {int id,
          int count,
          bool completed,
          int distributor,
          double price,
          DateTime createdAt}) =>
      OrdersTableData(
        id: id ?? this.id,
        count: count ?? this.count,
        completed: completed ?? this.completed,
        distributor: distributor ?? this.distributor,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('OrdersTableData(')
          ..write('id: $id, ')
          ..write('count: $count, ')
          ..write('completed: $completed, ')
          ..write('distributor: $distributor, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          count.hashCode,
          $mrjc(
              completed.hashCode,
              $mrjc(distributor.hashCode,
                  $mrjc(price.hashCode, createdAt.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is OrdersTableData &&
          other.id == this.id &&
          other.count == this.count &&
          other.completed == this.completed &&
          other.distributor == this.distributor &&
          other.price == this.price &&
          other.createdAt == this.createdAt);
}

class OrdersTableCompanion extends UpdateCompanion<OrdersTableData> {
  final Value<int> id;
  final Value<int> count;
  final Value<bool> completed;
  final Value<int> distributor;
  final Value<double> price;
  final Value<DateTime> createdAt;
  const OrdersTableCompanion({
    this.id = const Value.absent(),
    this.count = const Value.absent(),
    this.completed = const Value.absent(),
    this.distributor = const Value.absent(),
    this.price = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OrdersTableCompanion.insert({
    this.id = const Value.absent(),
    @required int count,
    @required bool completed,
    @required int distributor,
    @required double price,
    @required DateTime createdAt,
  })  : count = Value(count),
        completed = Value(completed),
        distributor = Value(distributor),
        price = Value(price),
        createdAt = Value(createdAt);
  static Insertable<OrdersTableData> custom({
    Expression<int> id,
    Expression<int> count,
    Expression<bool> completed,
    Expression<int> distributor,
    Expression<double> price,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (count != null) 'count': count,
      if (completed != null) 'completed': completed,
      if (distributor != null) 'distributor': distributor,
      if (price != null) 'price': price,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OrdersTableCompanion copyWith(
      {Value<int> id,
      Value<int> count,
      Value<bool> completed,
      Value<int> distributor,
      Value<double> price,
      Value<DateTime> createdAt}) {
    return OrdersTableCompanion(
      id: id ?? this.id,
      count: count ?? this.count,
      completed: completed ?? this.completed,
      distributor: distributor ?? this.distributor,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (distributor.present) {
      map['distributor'] = Variable<int>(distributor.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersTableCompanion(')
          ..write('id: $id, ')
          ..write('count: $count, ')
          ..write('completed: $completed, ')
          ..write('distributor: $distributor, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $OrdersTableTable extends OrdersTable
    with TableInfo<$OrdersTableTable, OrdersTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $OrdersTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedIntColumn _count;
  @override
  GeneratedIntColumn get count => _count ??= _constructCount();
  GeneratedIntColumn _constructCount() {
    return GeneratedIntColumn(
      'count',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn(
      'completed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _distributorMeta =
      const VerificationMeta('distributor');
  GeneratedIntColumn _distributor;
  @override
  GeneratedIntColumn get distributor =>
      _distributor ??= _constructDistributor();
  GeneratedIntColumn _constructDistributor() {
    return GeneratedIntColumn('distributor', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES distributors(id)');
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, count, completed, distributor, price, createdAt];
  @override
  $OrdersTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'orders';
  @override
  final String actualTableName = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<OrdersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count'], _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('distributor')) {
      context.handle(
          _distributorMeta,
          distributor.isAcceptableOrUnknown(
              data['distributor'], _distributorMeta));
    } else if (isInserting) {
      context.missing(_distributorMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdersTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return OrdersTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OrdersTableTable createAlias(String alias) {
    return $OrdersTableTable(_db, alias);
  }
}

class OrderItemsTableData extends DataClass
    implements Insertable<OrderItemsTableData> {
  final int itemId;
  final int id;
  final int quantity;
  final String name;
  final double price;
  final bool completed;
  final int orderId;
  OrderItemsTableData(
      {@required this.itemId,
      @required this.id,
      @required this.quantity,
      @required this.name,
      @required this.price,
      @required this.completed,
      @required this.orderId});
  factory OrderItemsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return OrderItemsTableData(
      itemId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}item_id']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      quantity:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
      orderId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}order_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<int>(orderId);
    }
    return map;
  }

  OrderItemsTableCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsTableCompanion(
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
    );
  }

  factory OrderItemsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return OrderItemsTableData(
      itemId: serializer.fromJson<int>(json['itemId']),
      id: serializer.fromJson<int>(json['id']),
      quantity: serializer.fromJson<int>(json['quantity']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      completed: serializer.fromJson<bool>(json['completed']),
      orderId: serializer.fromJson<int>(json['orderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'id': serializer.toJson<int>(id),
      'quantity': serializer.toJson<int>(quantity),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'completed': serializer.toJson<bool>(completed),
      'orderId': serializer.toJson<int>(orderId),
    };
  }

  OrderItemsTableData copyWith(
          {int itemId,
          int id,
          int quantity,
          String name,
          double price,
          bool completed,
          int orderId}) =>
      OrderItemsTableData(
        itemId: itemId ?? this.itemId,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        price: price ?? this.price,
        completed: completed ?? this.completed,
        orderId: orderId ?? this.orderId,
      );
  @override
  String toString() {
    return (StringBuffer('OrderItemsTableData(')
          ..write('itemId: $itemId, ')
          ..write('id: $id, ')
          ..write('quantity: $quantity, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('completed: $completed, ')
          ..write('orderId: $orderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      itemId.hashCode,
      $mrjc(
          id.hashCode,
          $mrjc(
              quantity.hashCode,
              $mrjc(
                  name.hashCode,
                  $mrjc(price.hashCode,
                      $mrjc(completed.hashCode, orderId.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is OrderItemsTableData &&
          other.itemId == this.itemId &&
          other.id == this.id &&
          other.quantity == this.quantity &&
          other.name == this.name &&
          other.price == this.price &&
          other.completed == this.completed &&
          other.orderId == this.orderId);
}

class OrderItemsTableCompanion extends UpdateCompanion<OrderItemsTableData> {
  final Value<int> itemId;
  final Value<int> id;
  final Value<int> quantity;
  final Value<String> name;
  final Value<double> price;
  final Value<bool> completed;
  final Value<int> orderId;
  const OrderItemsTableCompanion({
    this.itemId = const Value.absent(),
    this.id = const Value.absent(),
    this.quantity = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.completed = const Value.absent(),
    this.orderId = const Value.absent(),
  });
  OrderItemsTableCompanion.insert({
    @required int itemId,
    this.id = const Value.absent(),
    @required int quantity,
    @required String name,
    @required double price,
    @required bool completed,
    @required int orderId,
  })  : itemId = Value(itemId),
        quantity = Value(quantity),
        name = Value(name),
        price = Value(price),
        completed = Value(completed),
        orderId = Value(orderId);
  static Insertable<OrderItemsTableData> custom({
    Expression<int> itemId,
    Expression<int> id,
    Expression<int> quantity,
    Expression<String> name,
    Expression<double> price,
    Expression<bool> completed,
    Expression<int> orderId,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (id != null) 'id': id,
      if (quantity != null) 'quantity': quantity,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (completed != null) 'completed': completed,
      if (orderId != null) 'order_id': orderId,
    });
  }

  OrderItemsTableCompanion copyWith(
      {Value<int> itemId,
      Value<int> id,
      Value<int> quantity,
      Value<String> name,
      Value<double> price,
      Value<bool> completed,
      Value<int> orderId}) {
    return OrderItemsTableCompanion(
      itemId: itemId ?? this.itemId,
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      price: price ?? this.price,
      completed: completed ?? this.completed,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsTableCompanion(')
          ..write('itemId: $itemId, ')
          ..write('id: $id, ')
          ..write('quantity: $quantity, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('completed: $completed, ')
          ..write('orderId: $orderId')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTableTable extends OrderItemsTable
    with TableInfo<$OrderItemsTableTable, OrderItemsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $OrderItemsTableTable(this._db, [this._alias]);
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  GeneratedIntColumn _itemId;
  @override
  GeneratedIntColumn get itemId => _itemId ??= _constructItemId();
  GeneratedIntColumn _constructItemId() {
    return GeneratedIntColumn(
      'item_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedIntColumn _quantity;
  @override
  GeneratedIntColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn(
      'completed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  GeneratedIntColumn _orderId;
  @override
  GeneratedIntColumn get orderId => _orderId ??= _constructOrderId();
  GeneratedIntColumn _constructOrderId() {
    return GeneratedIntColumn('order_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES orders(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [itemId, id, quantity, name, price, completed, orderId];
  @override
  $OrderItemsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'order_items_table';
  @override
  final String actualTableName = 'order_items_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<OrderItemsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id'], _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity'], _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id'], _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItemsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return OrderItemsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OrderItemsTableTable createAlias(String alias) {
    return $OrderItemsTableTable(_db, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final int id;
  final String email;
  final String password;
  UserTableData(
      {@required this.id, @required this.email, @required this.password});
  factory UserTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return UserTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
    };
  }

  UserTableData copyWith({int id, String email, String password}) =>
      UserTableData(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(email.hashCode, password.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    @required String email,
    @required String password,
  })  : email = Value(email),
        password = Value(password);
  static Insertable<UserTableData> custom({
    Expression<int> id,
    Expression<String> email,
    Expression<String> password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    });
  }

  UserTableCompanion copyWith(
      {Value<int> id, Value<String> email, Value<String> password}) {
    return UserTableCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, email, password];
  @override
  $UserTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(_db, alias);
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $DistributorTableTable _distributorTable;
  $DistributorTableTable get distributorTable =>
      _distributorTable ??= $DistributorTableTable(this);
  $ItemTableTable _itemTable;
  $ItemTableTable get itemTable => _itemTable ??= $ItemTableTable(this);
  $ItemDistributionTableTable _itemDistributionTable;
  $ItemDistributionTableTable get itemDistributionTable =>
      _itemDistributionTable ??= $ItemDistributionTableTable(this);
  $OrdersTableTable _ordersTable;
  $OrdersTableTable get ordersTable => _ordersTable ??= $OrdersTableTable(this);
  $OrderItemsTableTable _orderItemsTable;
  $OrderItemsTableTable get orderItemsTable =>
      _orderItemsTable ??= $OrderItemsTableTable(this);
  $UserTableTable _userTable;
  $UserTableTable get userTable => _userTable ??= $UserTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        distributorTable,
        itemTable,
        itemDistributionTable,
        ordersTable,
        orderItemsTable,
        userTable
      ];
}
