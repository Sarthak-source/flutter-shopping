import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'placeholder.dart';

class TermsOfServiceScreen extends StatefulWidget {
  final String? url;

  const TermsOfServiceScreen({super.key, this.url});

  @override
  TermsOfServiceScreenState createState() => TermsOfServiceScreenState();
}

class TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;
  bool _isAtBottom = false;
  final ImagePicker _picker = ImagePicker();
  String? aadhaarImagePath;
  String? signedDocImagePath;
  String? panImagePath;
  final usercontroller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    if (widget.url != null && widget.url!.isNotEmpty) {
      _initializeWebView();
    } else {
      // Handle the case where the URL is null or empty
      log("URL is null or empty");
      // Optionally, you can show an error message to the user or load default content
    }
  }

  void _initializeWebView() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              setState(() {
                _isLoading = false; // Consider it loaded
              });
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    log("herewego ${widget.url!}");

    if (widget.url != null && widget.url!.isNotEmpty) {
      log("data here ${widget.url.toString()}");
      _webViewController.loadRequest(Uri.parse(widget.url!));
    } else {
      _webViewController.loadHtmlString(termsAndConditionsHtml);
    }
  }

  void _scrollToBottom() async {
    await _webViewController.runJavaScript(
      "window.scrollTo(0, document.body.scrollHeight);",
    );
    setState(() {
      _isAtBottom = true;
    });
  }

  void _scrollToTop() async {
    await _webViewController.runJavaScript(
      "window.scrollTo(0, 0);",
    );
    setState(() {
      _isAtBottom = false;
    });
  }

  Future<void> _selectImage(String type) async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        if (type == 'Aadhaar Card') {
          aadhaarImagePath = image.path;
        } else if (type == 'Signed doc') {
          signedDocImagePath = image.path;
        } else if (type == 'PAN Card') {
          panImagePath = image.path;
        }
      });
      log("Selected image for $type: ${image.path}");
    } else {
      log("No image selected for $type");
    }
  }

  Future<void> addImagesAndAgree() async {
    if (aadhaarImagePath != null &&
        signedDocImagePath != null &&
        panImagePath != null) {
      try {
        var data = await NetworkRepository.userSignupUpdate(
          MobileApp_Agr_Accepted: 'YES',
          Agrement_Signed_doc: signedDocImagePath!,
          MobileApp_PAN: panImagePath!,
          MobileApp_AADHAR: aadhaarImagePath!,
          memberId: usercontroller.user['party']['id'].toString(),
        );
        usercontroller.getUserData();
        log("datahelelele ${data.toString()}");
        if (data['conditions_accepted'] == 'YES') {
          Fluttertoast.showToast(
              msg: 'Agreement accepted and images uploaded successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Failed to upload images and accept agreement: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please upload all required images',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    //log('eazyeasy ${usercontroller.user['party']['id'].toString()}');
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                elevation: 0,
                backgroundColor: Colors.white70,
                title: Text('Agreement'),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height / 1.35,
                  child: Stack(
                    children: [
                      if (!_isLoading)
                        WebViewWidget(
                          controller: _webViewController,
                        ),
                      if (_isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _selectImage('Aadhaar Card'),
                              child: aadhaarImagePath != null
                                  ? Image.file(
                                      File(aadhaarImagePath!),
                                      width: 80,
                                      height: 80,
                                    )
                                  : Image.asset(
                                      'assets/images/aadhaar.png',
                                      width: 80,
                                      height: 80,
                                    ),
                            ),
                            const Text(
                              'Upload\nAadhaar Card',
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _selectImage('Signed doc'),
                              child: signedDocImagePath != null
                                  ? Image.file(
                                      File(signedDocImagePath!),
                                      width: 80,
                                      height: 80,
                                    )
                                  : Image.asset(
                                      'assets/images/signed-doc.png',
                                      width: 80,
                                      height: 80,
                                    ),
                            ),
                            const Text(
                              'Upload\nSigned doc',
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _selectImage('PAN Card'),
                              child: panImagePath != null
                                  ? Image.file(
                                      File(panImagePath!),
                                      width: 80,
                                      height: 80,
                                    )
                                  : Image.asset(
                                      'assets/images/pan.png',
                                      width: 80,
                                      height: 80,
                                    ),
                            ),
                            const Text(
                              'Upload\nPAN Card',
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 150,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isAtBottom ? _scrollToTop : _scrollToBottom,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isAtBottom ? 'Scroll to Top' : 'Scroll to Bottom',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: addImagesAndAgree,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: kPrimaryBlue,
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        'Accept & Continue',
                        style: TextStyle(color: kPrimaryBlue, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
