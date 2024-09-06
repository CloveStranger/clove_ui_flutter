import 'package:clove_ui_flutter/src/elements/complex_painter/model/layer_class.dart';
import 'package:flutter/foundation.dart';

class LayerController extends ChangeNotifier {
  LayerController() {
    _selectedId = _foreLayers.first.id;
  }

  final List<BasicLayer> _foreLayers = [
    PaintLayerInfo(),
  ];

  final List<BasicLayer> _backLayers = [
    PaintLayerInfo(),
  ];

  late String _selectedId;

  bool _hideForeLayer = false;

  bool _hideBackLayer = false;

  void addForeLayer(BasicLayer basicLayer) {
    _foreLayers.add(basicLayer);
    notifyListeners();
  }

  void addBackLayer(BasicLayer basicLayer) {
    _backLayers.add(basicLayer);
    notifyListeners();
  }

  void selectLayer(String id) {
    _selectedId = id;
    selectedLayer.refresh();
  }

  BasicLayer backUnShift() {
    var output = _backLayers.removeAt(0);
    notifyListeners();
    return output;
  }

  BasicLayer backPop() {
    BasicLayer output = _backLayers.removeLast();
    notifyListeners();
    return output;
  }

  BasicLayer foreUnShift() {
    var unShiftInfo = _foreLayers.removeAt(0);
    notifyListeners();
    return unShiftInfo;
  }

  BasicLayer forePop() {
    BasicLayer output = _backLayers.removeLast();
    notifyListeners();
    return output;
  }

  BasicLayer? deleteLayerById(String id) {
    int foreIndex = _foreLayers.indexWhere((e) => e.id == id);
    int backIndex = _backLayers.indexWhere((e) => e.id == id);
    if (foreIndex != -1) {
      BasicLayer popInfo = _foreLayers.removeAt(foreIndex);
      notifyListeners();
      return popInfo;
    }
    if (backIndex != -1) {
      BasicLayer popInfo = _backLayers.removeAt(backIndex);
      notifyListeners();
      return popInfo;
    }
    return null;
  }

  BasicLayer getLayerById(String id) {
    return wholeLayers.firstWhere((element) => element.id == id);
  }

  String get selectedId => _selectedId;

  List<BasicLayer> get foreLayers => _foreLayers;

  List<BasicLayer> get backLayers => _backLayers;

  List<BasicLayer> get wholeLayers => [..._backLayers, ..._foreLayers];

  List<String> get layerIds => wholeLayers.map((e) => e.id).toList();

  BasicLayer get selectedLayer => wholeLayers.firstWhere(
        (element) => element.id == _selectedId,
      );

  bool get hideForeLayer => _hideForeLayer;

  bool get hideBackLayer => _hideBackLayer;

  set hideForeLayer(bool value) {
    _hideForeLayer = value;
    notifyListeners();
  }

  set hideBackLayer(bool value) {
    _hideBackLayer = value;
    notifyListeners();
  }
}
