// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SinglePlantInformationStruct extends FFFirebaseStruct {
  SinglePlantInformationStruct({
    int? id,
    String? commonName,
    String? family,
    String? type,
    List<DimensionsStruct>? dimensions,
    String? cycle,
    String? watering,
    WateringBenchmarkStruct? wateringGeneralBenchmark,
    List<PlantPartStruct>? plantAnatomy,
    List<String>? sunlight,
    List<String>? pruningMonth,
    PruningCountStruct? pruningCount,
    String? seeds,
    List<String>? propagation,
    bool? flowers,
    String? floweringSeason,
    List<String>? soil,
    bool? cones,
    bool? fruits,
    bool? edibleFruit,
    String? fruitingSeason,
    String? harvestSeason,
    bool? leaf,
    bool? edibleLeaf,
    String? growthRate,
    String? maintance,
    bool? medicinal,
    bool? poisonousToHumans,
    bool? poisonousToPets,
    bool? droughtTolerant,
    bool? saltTolerant,
    bool? thorny,
    bool? invasive,
    bool? rare,
    bool? tropical,
    bool? cuisine,
    bool? indoor,
    String? careLevel,
    String? description,
    String? originalUrl,
    List<String>? origin,
    String? scientificName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _commonName = commonName,
        _family = family,
        _type = type,
        _dimensions = dimensions,
        _cycle = cycle,
        _watering = watering,
        _wateringGeneralBenchmark = wateringGeneralBenchmark,
        _plantAnatomy = plantAnatomy,
        _sunlight = sunlight,
        _pruningMonth = pruningMonth,
        _pruningCount = pruningCount,
        _seeds = seeds,
        _propagation = propagation,
        _flowers = flowers,
        _floweringSeason = floweringSeason,
        _soil = soil,
        _cones = cones,
        _fruits = fruits,
        _edibleFruit = edibleFruit,
        _fruitingSeason = fruitingSeason,
        _harvestSeason = harvestSeason,
        _leaf = leaf,
        _edibleLeaf = edibleLeaf,
        _growthRate = growthRate,
        _maintance = maintance,
        _medicinal = medicinal,
        _poisonousToHumans = poisonousToHumans,
        _poisonousToPets = poisonousToPets,
        _droughtTolerant = droughtTolerant,
        _saltTolerant = saltTolerant,
        _thorny = thorny,
        _invasive = invasive,
        _rare = rare,
        _tropical = tropical,
        _cuisine = cuisine,
        _indoor = indoor,
        _careLevel = careLevel,
        _description = description,
        _originalUrl = originalUrl,
        _origin = origin,
        _scientificName = scientificName,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "commonName" field.
  String? _commonName;
  String get commonName => _commonName ?? '';
  set commonName(String? val) => _commonName = val;

  bool hasCommonName() => _commonName != null;

  // "family" field.
  String? _family;
  String get family => _family ?? '';
  set family(String? val) => _family = val;

  bool hasFamily() => _family != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "dimensions" field.
  List<DimensionsStruct>? _dimensions;
  List<DimensionsStruct> get dimensions => _dimensions ?? const [];
  set dimensions(List<DimensionsStruct>? val) => _dimensions = val;

  void updateDimensions(Function(List<DimensionsStruct>) updateFn) {
    updateFn(_dimensions ??= []);
  }

  bool hasDimensions() => _dimensions != null;

  // "cycle" field.
  String? _cycle;
  String get cycle => _cycle ?? '';
  set cycle(String? val) => _cycle = val;

  bool hasCycle() => _cycle != null;

  // "watering" field.
  String? _watering;
  String get watering => _watering ?? '';
  set watering(String? val) => _watering = val;

  bool hasWatering() => _watering != null;

  // "wateringGeneralBenchmark" field.
  WateringBenchmarkStruct? _wateringGeneralBenchmark;
  WateringBenchmarkStruct get wateringGeneralBenchmark =>
      _wateringGeneralBenchmark ?? WateringBenchmarkStruct();
  set wateringGeneralBenchmark(WateringBenchmarkStruct? val) =>
      _wateringGeneralBenchmark = val;

  void updateWateringGeneralBenchmark(
      Function(WateringBenchmarkStruct) updateFn) {
    updateFn(_wateringGeneralBenchmark ??= WateringBenchmarkStruct());
  }

  bool hasWateringGeneralBenchmark() => _wateringGeneralBenchmark != null;

  // "plantAnatomy" field.
  List<PlantPartStruct>? _plantAnatomy;
  List<PlantPartStruct> get plantAnatomy => _plantAnatomy ?? const [];
  set plantAnatomy(List<PlantPartStruct>? val) => _plantAnatomy = val;

  void updatePlantAnatomy(Function(List<PlantPartStruct>) updateFn) {
    updateFn(_plantAnatomy ??= []);
  }

  bool hasPlantAnatomy() => _plantAnatomy != null;

  // "sunlight" field.
  List<String>? _sunlight;
  List<String> get sunlight => _sunlight ?? const [];
  set sunlight(List<String>? val) => _sunlight = val;

  void updateSunlight(Function(List<String>) updateFn) {
    updateFn(_sunlight ??= []);
  }

  bool hasSunlight() => _sunlight != null;

  // "pruningMonth" field.
  List<String>? _pruningMonth;
  List<String> get pruningMonth => _pruningMonth ?? const [];
  set pruningMonth(List<String>? val) => _pruningMonth = val;

  void updatePruningMonth(Function(List<String>) updateFn) {
    updateFn(_pruningMonth ??= []);
  }

  bool hasPruningMonth() => _pruningMonth != null;

  // "pruningCount" field.
  PruningCountStruct? _pruningCount;
  PruningCountStruct get pruningCount => _pruningCount ?? PruningCountStruct();
  set pruningCount(PruningCountStruct? val) => _pruningCount = val;

  void updatePruningCount(Function(PruningCountStruct) updateFn) {
    updateFn(_pruningCount ??= PruningCountStruct());
  }

  bool hasPruningCount() => _pruningCount != null;

  // "seeds" field.
  String? _seeds;
  String get seeds => _seeds ?? '';
  set seeds(String? val) => _seeds = val;

  bool hasSeeds() => _seeds != null;

  // "propagation" field.
  List<String>? _propagation;
  List<String> get propagation => _propagation ?? const [];
  set propagation(List<String>? val) => _propagation = val;

  void updatePropagation(Function(List<String>) updateFn) {
    updateFn(_propagation ??= []);
  }

  bool hasPropagation() => _propagation != null;

  // "flowers" field.
  bool? _flowers;
  bool get flowers => _flowers ?? false;
  set flowers(bool? val) => _flowers = val;

  bool hasFlowers() => _flowers != null;

  // "floweringSeason" field.
  String? _floweringSeason;
  String get floweringSeason => _floweringSeason ?? '';
  set floweringSeason(String? val) => _floweringSeason = val;

  bool hasFloweringSeason() => _floweringSeason != null;

  // "soil" field.
  List<String>? _soil;
  List<String> get soil => _soil ?? const [];
  set soil(List<String>? val) => _soil = val;

  void updateSoil(Function(List<String>) updateFn) {
    updateFn(_soil ??= []);
  }

  bool hasSoil() => _soil != null;

  // "cones" field.
  bool? _cones;
  bool get cones => _cones ?? false;
  set cones(bool? val) => _cones = val;

  bool hasCones() => _cones != null;

  // "fruits" field.
  bool? _fruits;
  bool get fruits => _fruits ?? false;
  set fruits(bool? val) => _fruits = val;

  bool hasFruits() => _fruits != null;

  // "edibleFruit" field.
  bool? _edibleFruit;
  bool get edibleFruit => _edibleFruit ?? false;
  set edibleFruit(bool? val) => _edibleFruit = val;

  bool hasEdibleFruit() => _edibleFruit != null;

  // "fruitingSeason" field.
  String? _fruitingSeason;
  String get fruitingSeason => _fruitingSeason ?? '';
  set fruitingSeason(String? val) => _fruitingSeason = val;

  bool hasFruitingSeason() => _fruitingSeason != null;

  // "harvestSeason" field.
  String? _harvestSeason;
  String get harvestSeason => _harvestSeason ?? '';
  set harvestSeason(String? val) => _harvestSeason = val;

  bool hasHarvestSeason() => _harvestSeason != null;

  // "leaf" field.
  bool? _leaf;
  bool get leaf => _leaf ?? false;
  set leaf(bool? val) => _leaf = val;

  bool hasLeaf() => _leaf != null;

  // "edibleLeaf" field.
  bool? _edibleLeaf;
  bool get edibleLeaf => _edibleLeaf ?? false;
  set edibleLeaf(bool? val) => _edibleLeaf = val;

  bool hasEdibleLeaf() => _edibleLeaf != null;

  // "growthRate" field.
  String? _growthRate;
  String get growthRate => _growthRate ?? '';
  set growthRate(String? val) => _growthRate = val;

  bool hasGrowthRate() => _growthRate != null;

  // "maintance" field.
  String? _maintance;
  String get maintance => _maintance ?? '';
  set maintance(String? val) => _maintance = val;

  bool hasMaintance() => _maintance != null;

  // "medicinal" field.
  bool? _medicinal;
  bool get medicinal => _medicinal ?? false;
  set medicinal(bool? val) => _medicinal = val;

  bool hasMedicinal() => _medicinal != null;

  // "poisonousToHumans" field.
  bool? _poisonousToHumans;
  bool get poisonousToHumans => _poisonousToHumans ?? false;
  set poisonousToHumans(bool? val) => _poisonousToHumans = val;

  bool hasPoisonousToHumans() => _poisonousToHumans != null;

  // "poisonousToPets" field.
  bool? _poisonousToPets;
  bool get poisonousToPets => _poisonousToPets ?? false;
  set poisonousToPets(bool? val) => _poisonousToPets = val;

  bool hasPoisonousToPets() => _poisonousToPets != null;

  // "droughtTolerant" field.
  bool? _droughtTolerant;
  bool get droughtTolerant => _droughtTolerant ?? false;
  set droughtTolerant(bool? val) => _droughtTolerant = val;

  bool hasDroughtTolerant() => _droughtTolerant != null;

  // "saltTolerant" field.
  bool? _saltTolerant;
  bool get saltTolerant => _saltTolerant ?? false;
  set saltTolerant(bool? val) => _saltTolerant = val;

  bool hasSaltTolerant() => _saltTolerant != null;

  // "thorny" field.
  bool? _thorny;
  bool get thorny => _thorny ?? false;
  set thorny(bool? val) => _thorny = val;

  bool hasThorny() => _thorny != null;

  // "invasive" field.
  bool? _invasive;
  bool get invasive => _invasive ?? false;
  set invasive(bool? val) => _invasive = val;

  bool hasInvasive() => _invasive != null;

  // "rare" field.
  bool? _rare;
  bool get rare => _rare ?? false;
  set rare(bool? val) => _rare = val;

  bool hasRare() => _rare != null;

  // "tropical" field.
  bool? _tropical;
  bool get tropical => _tropical ?? false;
  set tropical(bool? val) => _tropical = val;

  bool hasTropical() => _tropical != null;

  // "cuisine" field.
  bool? _cuisine;
  bool get cuisine => _cuisine ?? false;
  set cuisine(bool? val) => _cuisine = val;

  bool hasCuisine() => _cuisine != null;

  // "indoor" field.
  bool? _indoor;
  bool get indoor => _indoor ?? false;
  set indoor(bool? val) => _indoor = val;

  bool hasIndoor() => _indoor != null;

  // "careLevel" field.
  String? _careLevel;
  String get careLevel => _careLevel ?? '';
  set careLevel(String? val) => _careLevel = val;

  bool hasCareLevel() => _careLevel != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "originalUrl" field.
  String? _originalUrl;
  String get originalUrl => _originalUrl ?? '';
  set originalUrl(String? val) => _originalUrl = val;

  bool hasOriginalUrl() => _originalUrl != null;

  // "origin" field.
  List<String>? _origin;
  List<String> get origin => _origin ?? const [];
  set origin(List<String>? val) => _origin = val;

  void updateOrigin(Function(List<String>) updateFn) {
    updateFn(_origin ??= []);
  }

  bool hasOrigin() => _origin != null;

  // "scientificName" field.
  String? _scientificName;
  String get scientificName => _scientificName ?? '';
  set scientificName(String? val) => _scientificName = val;

  bool hasScientificName() => _scientificName != null;

  static SinglePlantInformationStruct fromMap(Map<String, dynamic> data) =>
      SinglePlantInformationStruct(
        id: castToType<int>(data['id']),
        commonName: data['commonName'] as String?,
        family: data['family'] as String?,
        type: data['type'] as String?,
        dimensions: getStructList(
          data['dimensions'],
          DimensionsStruct.fromMap,
        ),
        cycle: data['cycle'] as String?,
        watering: data['watering'] as String?,
        wateringGeneralBenchmark:
            data['wateringGeneralBenchmark'] is WateringBenchmarkStruct
                ? data['wateringGeneralBenchmark']
                : WateringBenchmarkStruct.maybeFromMap(
                    data['wateringGeneralBenchmark']),
        plantAnatomy: getStructList(
          data['plantAnatomy'],
          PlantPartStruct.fromMap,
        ),
        sunlight: getDataList(data['sunlight']),
        pruningMonth: getDataList(data['pruningMonth']),
        pruningCount: data['pruningCount'] is PruningCountStruct
            ? data['pruningCount']
            : PruningCountStruct.maybeFromMap(data['pruningCount']),
        seeds: data['seeds'] as String?,
        propagation: getDataList(data['propagation']),
        flowers: data['flowers'] as bool?,
        floweringSeason: data['floweringSeason'] as String?,
        soil: getDataList(data['soil']),
        cones: data['cones'] as bool?,
        fruits: data['fruits'] as bool?,
        edibleFruit: data['edibleFruit'] as bool?,
        fruitingSeason: data['fruitingSeason'] as String?,
        harvestSeason: data['harvestSeason'] as String?,
        leaf: data['leaf'] as bool?,
        edibleLeaf: data['edibleLeaf'] as bool?,
        growthRate: data['growthRate'] as String?,
        maintance: data['maintance'] as String?,
        medicinal: data['medicinal'] as bool?,
        poisonousToHumans: data['poisonousToHumans'] as bool?,
        poisonousToPets: data['poisonousToPets'] as bool?,
        droughtTolerant: data['droughtTolerant'] as bool?,
        saltTolerant: data['saltTolerant'] as bool?,
        thorny: data['thorny'] as bool?,
        invasive: data['invasive'] as bool?,
        rare: data['rare'] as bool?,
        tropical: data['tropical'] as bool?,
        cuisine: data['cuisine'] as bool?,
        indoor: data['indoor'] as bool?,
        careLevel: data['careLevel'] as String?,
        description: data['description'] as String?,
        originalUrl: data['originalUrl'] as String?,
        origin: getDataList(data['origin']),
        scientificName: data['scientificName'] as String?,
      );

  static SinglePlantInformationStruct? maybeFromMap(dynamic data) => data is Map
      ? SinglePlantInformationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'commonName': _commonName,
        'family': _family,
        'type': _type,
        'dimensions': _dimensions?.map((e) => e.toMap()).toList(),
        'cycle': _cycle,
        'watering': _watering,
        'wateringGeneralBenchmark': _wateringGeneralBenchmark?.toMap(),
        'plantAnatomy': _plantAnatomy?.map((e) => e.toMap()).toList(),
        'sunlight': _sunlight,
        'pruningMonth': _pruningMonth,
        'pruningCount': _pruningCount?.toMap(),
        'seeds': _seeds,
        'propagation': _propagation,
        'flowers': _flowers,
        'floweringSeason': _floweringSeason,
        'soil': _soil,
        'cones': _cones,
        'fruits': _fruits,
        'edibleFruit': _edibleFruit,
        'fruitingSeason': _fruitingSeason,
        'harvestSeason': _harvestSeason,
        'leaf': _leaf,
        'edibleLeaf': _edibleLeaf,
        'growthRate': _growthRate,
        'maintance': _maintance,
        'medicinal': _medicinal,
        'poisonousToHumans': _poisonousToHumans,
        'poisonousToPets': _poisonousToPets,
        'droughtTolerant': _droughtTolerant,
        'saltTolerant': _saltTolerant,
        'thorny': _thorny,
        'invasive': _invasive,
        'rare': _rare,
        'tropical': _tropical,
        'cuisine': _cuisine,
        'indoor': _indoor,
        'careLevel': _careLevel,
        'description': _description,
        'originalUrl': _originalUrl,
        'origin': _origin,
        'scientificName': _scientificName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'commonName': serializeParam(
          _commonName,
          ParamType.String,
        ),
        'family': serializeParam(
          _family,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'dimensions': serializeParam(
          _dimensions,
          ParamType.DataStruct,
          isList: true,
        ),
        'cycle': serializeParam(
          _cycle,
          ParamType.String,
        ),
        'watering': serializeParam(
          _watering,
          ParamType.String,
        ),
        'wateringGeneralBenchmark': serializeParam(
          _wateringGeneralBenchmark,
          ParamType.DataStruct,
        ),
        'plantAnatomy': serializeParam(
          _plantAnatomy,
          ParamType.DataStruct,
          isList: true,
        ),
        'sunlight': serializeParam(
          _sunlight,
          ParamType.String,
          isList: true,
        ),
        'pruningMonth': serializeParam(
          _pruningMonth,
          ParamType.String,
          isList: true,
        ),
        'pruningCount': serializeParam(
          _pruningCount,
          ParamType.DataStruct,
        ),
        'seeds': serializeParam(
          _seeds,
          ParamType.String,
        ),
        'propagation': serializeParam(
          _propagation,
          ParamType.String,
          isList: true,
        ),
        'flowers': serializeParam(
          _flowers,
          ParamType.bool,
        ),
        'floweringSeason': serializeParam(
          _floweringSeason,
          ParamType.String,
        ),
        'soil': serializeParam(
          _soil,
          ParamType.String,
          isList: true,
        ),
        'cones': serializeParam(
          _cones,
          ParamType.bool,
        ),
        'fruits': serializeParam(
          _fruits,
          ParamType.bool,
        ),
        'edibleFruit': serializeParam(
          _edibleFruit,
          ParamType.bool,
        ),
        'fruitingSeason': serializeParam(
          _fruitingSeason,
          ParamType.String,
        ),
        'harvestSeason': serializeParam(
          _harvestSeason,
          ParamType.String,
        ),
        'leaf': serializeParam(
          _leaf,
          ParamType.bool,
        ),
        'edibleLeaf': serializeParam(
          _edibleLeaf,
          ParamType.bool,
        ),
        'growthRate': serializeParam(
          _growthRate,
          ParamType.String,
        ),
        'maintance': serializeParam(
          _maintance,
          ParamType.String,
        ),
        'medicinal': serializeParam(
          _medicinal,
          ParamType.bool,
        ),
        'poisonousToHumans': serializeParam(
          _poisonousToHumans,
          ParamType.bool,
        ),
        'poisonousToPets': serializeParam(
          _poisonousToPets,
          ParamType.bool,
        ),
        'droughtTolerant': serializeParam(
          _droughtTolerant,
          ParamType.bool,
        ),
        'saltTolerant': serializeParam(
          _saltTolerant,
          ParamType.bool,
        ),
        'thorny': serializeParam(
          _thorny,
          ParamType.bool,
        ),
        'invasive': serializeParam(
          _invasive,
          ParamType.bool,
        ),
        'rare': serializeParam(
          _rare,
          ParamType.bool,
        ),
        'tropical': serializeParam(
          _tropical,
          ParamType.bool,
        ),
        'cuisine': serializeParam(
          _cuisine,
          ParamType.bool,
        ),
        'indoor': serializeParam(
          _indoor,
          ParamType.bool,
        ),
        'careLevel': serializeParam(
          _careLevel,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'originalUrl': serializeParam(
          _originalUrl,
          ParamType.String,
        ),
        'origin': serializeParam(
          _origin,
          ParamType.String,
          isList: true,
        ),
        'scientificName': serializeParam(
          _scientificName,
          ParamType.String,
        ),
      }.withoutNulls;

  static SinglePlantInformationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SinglePlantInformationStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        commonName: deserializeParam(
          data['commonName'],
          ParamType.String,
          false,
        ),
        family: deserializeParam(
          data['family'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        dimensions: deserializeStructParam<DimensionsStruct>(
          data['dimensions'],
          ParamType.DataStruct,
          true,
          structBuilder: DimensionsStruct.fromSerializableMap,
        ),
        cycle: deserializeParam(
          data['cycle'],
          ParamType.String,
          false,
        ),
        watering: deserializeParam(
          data['watering'],
          ParamType.String,
          false,
        ),
        wateringGeneralBenchmark: deserializeStructParam(
          data['wateringGeneralBenchmark'],
          ParamType.DataStruct,
          false,
          structBuilder: WateringBenchmarkStruct.fromSerializableMap,
        ),
        plantAnatomy: deserializeStructParam<PlantPartStruct>(
          data['plantAnatomy'],
          ParamType.DataStruct,
          true,
          structBuilder: PlantPartStruct.fromSerializableMap,
        ),
        sunlight: deserializeParam<String>(
          data['sunlight'],
          ParamType.String,
          true,
        ),
        pruningMonth: deserializeParam<String>(
          data['pruningMonth'],
          ParamType.String,
          true,
        ),
        pruningCount: deserializeStructParam(
          data['pruningCount'],
          ParamType.DataStruct,
          false,
          structBuilder: PruningCountStruct.fromSerializableMap,
        ),
        seeds: deserializeParam(
          data['seeds'],
          ParamType.String,
          false,
        ),
        propagation: deserializeParam<String>(
          data['propagation'],
          ParamType.String,
          true,
        ),
        flowers: deserializeParam(
          data['flowers'],
          ParamType.bool,
          false,
        ),
        floweringSeason: deserializeParam(
          data['floweringSeason'],
          ParamType.String,
          false,
        ),
        soil: deserializeParam<String>(
          data['soil'],
          ParamType.String,
          true,
        ),
        cones: deserializeParam(
          data['cones'],
          ParamType.bool,
          false,
        ),
        fruits: deserializeParam(
          data['fruits'],
          ParamType.bool,
          false,
        ),
        edibleFruit: deserializeParam(
          data['edibleFruit'],
          ParamType.bool,
          false,
        ),
        fruitingSeason: deserializeParam(
          data['fruitingSeason'],
          ParamType.String,
          false,
        ),
        harvestSeason: deserializeParam(
          data['harvestSeason'],
          ParamType.String,
          false,
        ),
        leaf: deserializeParam(
          data['leaf'],
          ParamType.bool,
          false,
        ),
        edibleLeaf: deserializeParam(
          data['edibleLeaf'],
          ParamType.bool,
          false,
        ),
        growthRate: deserializeParam(
          data['growthRate'],
          ParamType.String,
          false,
        ),
        maintance: deserializeParam(
          data['maintance'],
          ParamType.String,
          false,
        ),
        medicinal: deserializeParam(
          data['medicinal'],
          ParamType.bool,
          false,
        ),
        poisonousToHumans: deserializeParam(
          data['poisonousToHumans'],
          ParamType.bool,
          false,
        ),
        poisonousToPets: deserializeParam(
          data['poisonousToPets'],
          ParamType.bool,
          false,
        ),
        droughtTolerant: deserializeParam(
          data['droughtTolerant'],
          ParamType.bool,
          false,
        ),
        saltTolerant: deserializeParam(
          data['saltTolerant'],
          ParamType.bool,
          false,
        ),
        thorny: deserializeParam(
          data['thorny'],
          ParamType.bool,
          false,
        ),
        invasive: deserializeParam(
          data['invasive'],
          ParamType.bool,
          false,
        ),
        rare: deserializeParam(
          data['rare'],
          ParamType.bool,
          false,
        ),
        tropical: deserializeParam(
          data['tropical'],
          ParamType.bool,
          false,
        ),
        cuisine: deserializeParam(
          data['cuisine'],
          ParamType.bool,
          false,
        ),
        indoor: deserializeParam(
          data['indoor'],
          ParamType.bool,
          false,
        ),
        careLevel: deserializeParam(
          data['careLevel'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        originalUrl: deserializeParam(
          data['originalUrl'],
          ParamType.String,
          false,
        ),
        origin: deserializeParam<String>(
          data['origin'],
          ParamType.String,
          true,
        ),
        scientificName: deserializeParam(
          data['scientificName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SinglePlantInformationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SinglePlantInformationStruct &&
        id == other.id &&
        commonName == other.commonName &&
        family == other.family &&
        type == other.type &&
        listEquality.equals(dimensions, other.dimensions) &&
        cycle == other.cycle &&
        watering == other.watering &&
        wateringGeneralBenchmark == other.wateringGeneralBenchmark &&
        listEquality.equals(plantAnatomy, other.plantAnatomy) &&
        listEquality.equals(sunlight, other.sunlight) &&
        listEquality.equals(pruningMonth, other.pruningMonth) &&
        pruningCount == other.pruningCount &&
        seeds == other.seeds &&
        listEquality.equals(propagation, other.propagation) &&
        flowers == other.flowers &&
        floweringSeason == other.floweringSeason &&
        listEquality.equals(soil, other.soil) &&
        cones == other.cones &&
        fruits == other.fruits &&
        edibleFruit == other.edibleFruit &&
        fruitingSeason == other.fruitingSeason &&
        harvestSeason == other.harvestSeason &&
        leaf == other.leaf &&
        edibleLeaf == other.edibleLeaf &&
        growthRate == other.growthRate &&
        maintance == other.maintance &&
        medicinal == other.medicinal &&
        poisonousToHumans == other.poisonousToHumans &&
        poisonousToPets == other.poisonousToPets &&
        droughtTolerant == other.droughtTolerant &&
        saltTolerant == other.saltTolerant &&
        thorny == other.thorny &&
        invasive == other.invasive &&
        rare == other.rare &&
        tropical == other.tropical &&
        cuisine == other.cuisine &&
        indoor == other.indoor &&
        careLevel == other.careLevel &&
        description == other.description &&
        originalUrl == other.originalUrl &&
        listEquality.equals(origin, other.origin) &&
        scientificName == other.scientificName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        commonName,
        family,
        type,
        dimensions,
        cycle,
        watering,
        wateringGeneralBenchmark,
        plantAnatomy,
        sunlight,
        pruningMonth,
        pruningCount,
        seeds,
        propagation,
        flowers,
        floweringSeason,
        soil,
        cones,
        fruits,
        edibleFruit,
        fruitingSeason,
        harvestSeason,
        leaf,
        edibleLeaf,
        growthRate,
        maintance,
        medicinal,
        poisonousToHumans,
        poisonousToPets,
        droughtTolerant,
        saltTolerant,
        thorny,
        invasive,
        rare,
        tropical,
        cuisine,
        indoor,
        careLevel,
        description,
        originalUrl,
        origin,
        scientificName
      ]);
}

SinglePlantInformationStruct createSinglePlantInformationStruct({
  int? id,
  String? commonName,
  String? family,
  String? type,
  String? cycle,
  String? watering,
  WateringBenchmarkStruct? wateringGeneralBenchmark,
  PruningCountStruct? pruningCount,
  String? seeds,
  bool? flowers,
  String? floweringSeason,
  bool? cones,
  bool? fruits,
  bool? edibleFruit,
  String? fruitingSeason,
  String? harvestSeason,
  bool? leaf,
  bool? edibleLeaf,
  String? growthRate,
  String? maintance,
  bool? medicinal,
  bool? poisonousToHumans,
  bool? poisonousToPets,
  bool? droughtTolerant,
  bool? saltTolerant,
  bool? thorny,
  bool? invasive,
  bool? rare,
  bool? tropical,
  bool? cuisine,
  bool? indoor,
  String? careLevel,
  String? description,
  String? originalUrl,
  String? scientificName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SinglePlantInformationStruct(
      id: id,
      commonName: commonName,
      family: family,
      type: type,
      cycle: cycle,
      watering: watering,
      wateringGeneralBenchmark: wateringGeneralBenchmark ??
          (clearUnsetFields ? WateringBenchmarkStruct() : null),
      pruningCount:
          pruningCount ?? (clearUnsetFields ? PruningCountStruct() : null),
      seeds: seeds,
      flowers: flowers,
      floweringSeason: floweringSeason,
      cones: cones,
      fruits: fruits,
      edibleFruit: edibleFruit,
      fruitingSeason: fruitingSeason,
      harvestSeason: harvestSeason,
      leaf: leaf,
      edibleLeaf: edibleLeaf,
      growthRate: growthRate,
      maintance: maintance,
      medicinal: medicinal,
      poisonousToHumans: poisonousToHumans,
      poisonousToPets: poisonousToPets,
      droughtTolerant: droughtTolerant,
      saltTolerant: saltTolerant,
      thorny: thorny,
      invasive: invasive,
      rare: rare,
      tropical: tropical,
      cuisine: cuisine,
      indoor: indoor,
      careLevel: careLevel,
      description: description,
      originalUrl: originalUrl,
      scientificName: scientificName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SinglePlantInformationStruct? updateSinglePlantInformationStruct(
  SinglePlantInformationStruct? singlePlantInformation, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    singlePlantInformation
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSinglePlantInformationStructData(
  Map<String, dynamic> firestoreData,
  SinglePlantInformationStruct? singlePlantInformation,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (singlePlantInformation == null) {
    return;
  }
  if (singlePlantInformation.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      singlePlantInformation.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final singlePlantInformationData = getSinglePlantInformationFirestoreData(
      singlePlantInformation, forFieldValue);
  final nestedData =
      singlePlantInformationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      singlePlantInformation.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSinglePlantInformationFirestoreData(
  SinglePlantInformationStruct? singlePlantInformation, [
  bool forFieldValue = false,
]) {
  if (singlePlantInformation == null) {
    return {};
  }
  final firestoreData = mapToFirestore(singlePlantInformation.toMap());

  // Handle nested data for "wateringGeneralBenchmark" field.
  addWateringBenchmarkStructData(
    firestoreData,
    singlePlantInformation.hasWateringGeneralBenchmark()
        ? singlePlantInformation.wateringGeneralBenchmark
        : null,
    'wateringGeneralBenchmark',
    forFieldValue,
  );

  // Handle nested data for "pruningCount" field.
  addPruningCountStructData(
    firestoreData,
    singlePlantInformation.hasPruningCount()
        ? singlePlantInformation.pruningCount
        : null,
    'pruningCount',
    forFieldValue,
  );

  // Add any Firestore field values
  singlePlantInformation.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSinglePlantInformationListFirestoreData(
  List<SinglePlantInformationStruct>? singlePlantInformations,
) =>
    singlePlantInformations
        ?.map((e) => getSinglePlantInformationFirestoreData(e, true))
        .toList() ??
    [];
