# cordova-plugin-firebase-analytics<br>[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url]
> Cordova plugin for [Firebase Analytics](https://firebase.google.com/docs/analytics/)

## Installation

    cordova plugin add cordova-plugin-firebase-analytics --save

Plugin depends on [cordova-support-google-services](https://github.com/chemerisuk/cordova-support-google-services) for setting up google services properly. Please read the [README](https://github.com/chemerisuk/cordova-support-google-services/blob/master/README.md) carefully in order to avoid common issues with a project configuration.

Use variable `FIREBASE_CORE_VERSION` to override dependency version on Android.

NOTE: on iOS in order to collect demographic, age, gender data etc. you should additionally [include `AdSupport.framework`](https://firebase.google.com/support/guides/analytics-adsupport) into your project.

## Supported Platforms

- iOS
- Android

## Methods
Every method returns a promise that fulfills when a call was successful.

### logEvent(_name_, _params_)
Logs an app event.
```js
cordova.plugins.firebase.analytics.logEvent("my_event", {param1: "value1"});
```

Be aware of [automatically collected events](https://support.google.com/firebase/answer/6317485).

### setUserId(_id_)
Sets the user ID property.
```js
cordova.plugins.firebase.analytics.setUserId("12345");
```
This feature must be used in accordance with [Google's Privacy Policy](https://www.google.com/policies/privacy).

### setUserProperty(_name_, _value_)
Sets a user property to a given value.
```js
cordova.plugins.firebase.analytics.setUserProperty("name1", "value1");
```

Be aware of [automatically collected user properties](https://support.google.com/firebase/answer/6317486?hl=en&ref_topic=6317484).

### setCurrentScreen(_name_)
Sets the current screen name, which specifies the current visual context in your app. This helps identify the areas in your app where users spend their time and how they interact with your app.
```js
cordova.plugins.firebase.analytics.setCurrentScreen("User profile");
```

### setEnabled(_enabled_)
Sets whether analytics collection is enabled for this app on this device.
```js
cordova.plugins.firebase.analytics.setEnabled(false);
```

### resetAnalyticsData()
Clears all analytics data for this instance from the device and resets the app instance ID
```js
cordova.plugins.firebase.analytics.resetAnalyticsData();
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-firebase-analytics
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-firebase-analytics.svg
[npm-downloads]: https://img.shields.io/npm/dm/cordova-plugin-firebase-analytics.svg
