// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:testproject/screens/localAndWebObjectsview.dart';
// import 'package:vector_math/vector_math.dart';

// Future<void> onLocalObjectButtonPressed() async {
//  // 1
//  if (localObjectNode != null) {
//    arObjectManager.removeNode(localObjectNode!);
//    localObjectNode = null;
//  } else {
//    // 2
//    var newNode = ARNode(
//        type: NodeType.localGLTF2,
//        uri: "assets/Chicken_01/Chicken_01.gltf",
//        scale: Vector3(0.2, 0.2, 0.2),
//        position: Vector3(0.0, 0.0, 0.0),
//        rotation: Vector4(1.0, 0.0, 0.0, 0.0));
//    // 3
//    bool? didAddLocalNode = await arObjectManager.addNode(newNode);
//    localObjectNode = (didAddLocalNode!) ? newNode : null;
//  }
// }

// Future<void> onWebObjectAtButtonPressed() async {
//  if (webObjectNode != null) {
//    arObjectManager.removeNode(webObjectNode!);
//    webObjectNode = null;
//  } else {
//    var newNode = ARNode(
//        type: NodeType.webGLB,
//        uri:
//            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
//        scale: Vector3(0.2, 0.2, 0.2));
//    bool? didAddWebNode = await arObjectManager.addNode(newNode);
//    webObjectNode = (didAddWebNode!) ? newNode : null;
//  }