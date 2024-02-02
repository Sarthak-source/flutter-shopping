import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class InternetError {
  static final _instance = InternetError.internal();
  factory InternetError() => _instance;
  InternetError.internal();

  static OverlayEntry? entry;

  void show(context, page) => addOverlayEntry();
  void hide() => removeOverlay();

  bool get isShow => entry != null;

  addOverlayEntry() {
    if (entry != null) return;
    entry = OverlayEntry(builder: (BuildContext context) {
      return LayoutBuilder(builder: (_, BoxConstraints constraints) {
        return Material(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "No Internet Connection",
                  ),
                  SizedBox(height:  getProportionateScreenHeight(30),),
                 
                  
                  InkWell(
                    onTap: () {
                      removeOverlay();
                    },
                    child: Container(
                      height: 60,
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Center(
                        child: Text(
                          "Check Your network",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });

    addoverlay(entry!);
  }

  addoverlay(OverlayEntry entry) async {
    Overlay.of(Get.overlayContext!).insert(entry);
  }

  removeOverlay() {
    entry?.remove();
    entry = null;
  }
}
