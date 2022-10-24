import 'package:flutter/material.dart';

class DynamicControllerUI {
  TextEditingController getControllerOf(
      String name, Map<String, TextEditingController> controllerMap) {
    var controller = controllerMap[name];
    if (controller == null) {
      controller = TextEditingController();
      controllerMap[name] = controller;
    }
    return controller;
  }
}
