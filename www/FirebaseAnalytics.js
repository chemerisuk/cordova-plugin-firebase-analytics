var exec = require("cordova/exec");
var PLUGIN_NAME = "FirebaseAnalytics";

module.exports = {
    logEvent: function(name, params, success, error) {
        exec(success, error, PLUGIN_NAME, "logEvent", [name, params || {}]);
    },
    setUserId: function(userId, success, error) {
        exec(success, error, PLUGIN_NAME, "setUserId", [userId]);
    },
    setUserProperty: function(name, value, success, error) {
        exec(success, error, PLUGIN_NAME, "setUserProperty", [name, value]);
    },
    setEnabled: function(enabled) {
        exec(success, error, PLUGIN_NAME, "setEnabled", [String(enabled !== false)]);
    },
    setCurrentScreen: function(name) {
        exec(success, error, PLUGIN_NAME, "setCurrentScreen", [name]);
    }
};
