#import <Cordova/CDV.h>

@interface FirebaseAnalyticsPlugin : CDVPlugin

- (void)logEvent:(CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)setUserProperty:(CDVInvokedUrlCommand*)command;
- (void)setEnabled:(CDVInvokedUrlCommand*)command;
- (void)setCurrentScreen:(CDVInvokedUrlCommand*)command;
- (void)resetAnalyticsData:(CDVInvokedUrlCommand*)command;
- (void)setDefaultEventParameters:(CDVInvokedUrlCommand*)command;
- (void)initiateOnDeviceConversionMeasurementWithEmail:(CDVInvokedUrlCommand*)command;
- (void)initiateOnDeviceConversionMeasurementWithPhoneNumber:(CDVInvokedUrlCommand*)command;
- (void)initiateOnDeviceConversionMeasurementWithHashedEmail:(CDVInvokedUrlCommand*)command;
- (void)initiateOnDeviceConversionMeasurementWithHashedPhoneNumber:(CDVInvokedUrlCommand*)command;
@end
