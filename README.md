# cordova-plugin-firebase-analytics<br>[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url]
> Cordova plugin for [Firebase Analytics](https://firebase.google.com/docs/analytics/)

## Installation

    cordova plugin add cordova-plugin-firebase-analytics --save

Go yo firebase console and export `google-services.json` and `GoogleService-Info.plist`. Put those files into `platforms/android` and `platforms/ios` accordingly.

##### Build Error: Failed to apply plugin [class 'com.google.gms.googleservices.GoogleServicesPlugin']
It looks like you have another dependency on a google play services lib with a generic verison `*`. You have to fix ALL dependency version(s) to be more more specific like `10.2.+`.

##### Build Error: Could not generate a proxy class for class com.google.gms.googleservices.GoogleServicesTask.
Open `platform/android/build.gradle` and change version of the first `com.android.tools.build:gradle`:

    classpath 'com.android.tools.build:gradle:1.2.3+'

##### Duplicate resources: .../platforms/android/build/generated/res/google-services/armv7/debug/values/values.xml:string/google_api_key, .../platforms/android/res/values/strings.xml:string/google_api_key
Remove `google_api_key` and `google_app_id` from any existing xml file from `platform/android/res/` folder. Those values now come from an automatically generated `values.xml`.

NOTE: on iOS in order to collect demographic, age, gender data etc. you should additionally [include `AdSupport.framework`](https://firebase.google.com/support/guides/analytics-adsupport) into your project.

## Supported Platforms

- iOS
- Android

## Methods

### logEvent(_name_, _params_)
Logs an app event.
```js
window.cordova.plugins.firebase.analytics.logEvent("page_view", {page: "dashboard"});
```

Be aware of [automatically collected events](https://support.google.com/firebase/answer/6317485).

### setUserId(_id_)
Sets the user ID property.
```js
window.cordova.plugins.firebase.analytics.setUserId("12345");
```
This feature must be used in accordance with [Google's Privacy Policy](https://www.google.com/policies/privacy).

### setUserProperty(_name_, _value_)
Sets a user property to a given value.
```js
window.cordova.plugins.firebase.analytics.setUserProperty("name1", "value1");
```

Be aware of [automatically collected user properties](https://support.google.com/firebase/answer/6317486?hl=en&ref_topic=6317484).

### setEnabled(_enabled_)
Sets whether analytics collection is enabled for this app on this device.
```js
window.cordova.plugins.firebase.analytics.setEnabled(false);
```

### setCurrentScreen(_name_)
Sets the current screen name, which specifies the current visual context in your app. This helps identify the areas in your app where users spend their time and how they interact with your app.
```js
window.cordova.plugins.firebase.analytics.setCurrentScreen("User profile");
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-firebase-analytics
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-firebase-analytics.svg
[npm-downloads]: https://img.shields.io/npm/dt/cordova-plugin-firebase-analytics.svg
