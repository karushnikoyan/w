import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_consts.dart';
import 'home_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit()
      : super(const HomeScreenState(stage: HomeScreenStage.loading)) {
    load();
  }

  Future<void> load() async {
    final String url = await _getLocalUrl();
    if (url.isEmpty) {
      final remoteUrl = await _checkForRemote().catchError((e) {
        emit(state.copyWith(
            stage: HomeScreenStage.error, errorMessage: e.toString()));
      });
      final isEmu = await _checkIsEmu();
      if (remoteUrl.isEmpty || isEmu) {
      // if (remoteUrl.isEmpty ) {
        emit(state.copyWith(stage: HomeScreenStage.dummy));
      } else {
        await _setLocalUrl(remoteUrl);
        emit(state.copyWith(stage: HomeScreenStage.webView, url: remoteUrl));
      }
    } else {
      emit(state.copyWith(stage: HomeScreenStage.webView, url: url));
    }
  }

  // _clearLocalUri() async{
  //   final sharedPref = await SharedPreferences.getInstance();
  //   await sharedPref.remove(urlKey);
  //   print(sharedPref.getString(urlKey));
  // }

  Future<bool> _checkIsEmu() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final em = await deviceInfoPlugin.androidInfo;
    var phoneModel = em.model;
    var buildProduct = em.product;
    var buildHardware = em.hardware;
    var result = (em.fingerprint.startsWith("generic") ||
        phoneModel.contains("google_sdk") ||
        phoneModel.contains("droid4x") ||
        phoneModel.contains("Emulator") ||
        phoneModel.contains("Android SDK built for x86") ||
        em.manufacturer.contains("Genymotion") ||
        buildHardware == "goldfish" ||
        buildHardware == "vbox86" ||
        buildProduct == "sdk" ||
        buildProduct == "google_sdk" ||
        buildProduct == "sdk_x86" ||
        buildProduct == "vbox86p" ||
        em.brand.contains('google') ||
        em.board.toLowerCase().contains("nox") ||
        em.bootloader.toLowerCase().contains("nox") ||
        buildHardware.toLowerCase().contains("nox") ||
        !em.isPhysicalDevice ||
        buildProduct.toLowerCase().contains("nox"));
    if (result) return true;
    result = result ||
        (em.brand.startsWith("generic") && em.device.startsWith("generic"));
    if (result) return true;
    result = result || ("google_sdk" == buildProduct);
    return result;
  }

  Future<String> _checkForRemote() async {
    try {
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await remoteConfig.fetchAndActivate();
      return remoteConfig.getString(urlKey);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> _getLocalUrl() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? url = sharedPref.getString(urlKey);
    return url ?? "";
  }

  Future<void> _setLocalUrl(String url) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(urlKey, url);
  }
}
