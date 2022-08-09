interface CordovaPlugins {
    firebase: FirebasePlugins;
}

interface FirebasePlugins {
    analytics: typeof import("./FirebaseAnalytics");
}
