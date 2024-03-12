import 'package:boilerlib/core/permission_util/permission_util.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  XFile? fileData;
  bool isActiveTorch = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initCamera();
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    await _initializeCameraController();
    await PermissionUtil().permissionCamera();
    await PermissionUtil().permissionStorage();
  }

  Future<void> _initializeCameraController() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras!.first,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
  }

  Future<void> setFocus(
      TapDownDetails details, BoxConstraints constraints) async {
    final Offset offsetDevice = Offset(
        details.localPosition.dx / constraints.maxWidth,
        details.localPosition.dy / constraints.maxHeight);
    await _controller?.setExposurePoint(offsetDevice);
    await _controller?.setFocusPoint(offsetDevice);
  }

  Future<void> setFlashMode(FlashMode mode) async {
    await _controller?.setFlashMode(mode);
  }

  Future<void> takePicturePhoto() async {
    _controller?.takePicture().then((value) {
      if (mounted) {
        setState(() {
          fileData = value;
        });
      }
      print("Photo Captured!");
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = _controller!;

    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameras?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            if (_controller != null)
              if (_controller!.value.isInitialized)
                Positioned.fill(
                    child: LayoutBuilder(builder: ((context, constraints) {
                  final size = constraints.biggest;
                  var scale = size.aspectRatio * _controller!.value.aspectRatio;
                  if (scale < 1) scale = 1 / scale;

                  return GestureDetector(
                    onTapDown: (detail) {
                      setFocus(detail, constraints);
                    },
                    child: Transform.scale(
                      scale: scale,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1 / _controller!.value.aspectRatio,
                          child: _controller?.buildPreview(),
                        ),
                      ),
                    ),
                  );
                }))),
            Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).size.height * 0.1,
                child: GestureDetector(
                  onTap: () {
                    takePicturePhoto();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 24,
                    ),
                  ),
                )),
            Positioned(
                right: 24,
                top: kToolbarHeight + 24,
                child: GestureDetector(
                  onTap: () {
                    if (isActiveTorch) {
                      setFlashMode(FlashMode.off);
                      setState(() {
                        isActiveTorch = !isActiveTorch;
                      });
                    } else {
                      setFlashMode(FlashMode.always);
                      setState(() {
                        isActiveTorch = !isActiveTorch;
                      });
                    }
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      isActiveTorch ? Icons.flash_on : Icons.flash_off,
                      size: 24,
                    ),
                  ),
                ))
          ],
        ));
  }
}
