/**
 * test comment
 */
interface CordovaPlugins {
    /**
     * test firebase
     */
    firebase: FirebasePlugins;
}

interface FirebasePlugins {
    analytics: typeof import("./FirebaseAnalytics");
}
