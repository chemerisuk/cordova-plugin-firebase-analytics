package by.chemerisuk.cordova.firebase;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.google.firebase.analytics.FirebaseAnalytics;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;


public class FirebaseAnalyticsPlugin extends CordovaPlugin {
    private static final String TAG = "FirebaseAnalyticsPlugin";

    private FirebaseAnalytics firebaseAnalytics;

    @Override
    protected void pluginInitialize() {
        Log.d(TAG, "Starting Firebase Analytics plugin");

        Context context = this.cordova.getActivity().getApplicationContext();

        this.firebaseAnalytics = FirebaseAnalytics.getInstance(context);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("logEvent".equals(action)) {
            logEvent(callbackContext, args.getString(0), args.getJSONObject(1));

            return true;
        } else if ("setUserId".equals(action)) {
            setUserId(callbackContext, args.getString(0));

            return true;
        } else if ("setUserProperty".equals(action)) {
            setUserProperty(callbackContext, args.getString(0), args.getString(1));

            return true;
        } else if ("setEnabled".equals(action)) {
            setEnabled(callbackContext, args.getBoolean(0));

            return true;
        } else if ("setCurrentScreen".equals(action)) {
            setCurrentScreen(callbackContext, args.getString(0));

            return true;
        }

        return false;
    }

    private void logEvent(CallbackContext callbackContext, String name, JSONObject params) throws JSONException {
        Bundle bundle = new Bundle();
        Iterator iter = params.keys();

        while (iter.hasNext()) {
            String key = (String) iter.next();
            Object value = params.get(key);

            if (value instanceof Integer || value instanceof Double) {
                bundle.putFloat(key, ((Number) value).floatValue());
            } else {
                bundle.putString(key, value.toString());
            }
        }

        this.firebaseAnalytics.logEvent(name, bundle);

        callbackContext.success();
    }

    private void setUserId(CallbackContext callbackContext, String userId) {
        this.firebaseAnalytics.setUserId(userId);

        callbackContext.success();
    }

    private void setUserProperty(CallbackContext callbackContext, String name, String value) {
        this.firebaseAnalytics.setUserProperty(name, value);

        callbackContext.success();
    }

    private void setEnabled(CallbackContext callbackContext, boolean enabled) {
        this.firebaseAnalytics.setAnalyticsCollectionEnabled(enabled);

        callbackContext.success();
    }

    private void setCurrentScreen(final CallbackContext callbackContext, final String screenName) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            public void run() {
                firebaseAnalytics.setCurrentScreen(
                    cordova.getActivity(),
                    screenName,
                    null
                );

                callbackContext.success();
            }
        });
    }
}
