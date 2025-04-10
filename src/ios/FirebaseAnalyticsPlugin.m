#import "FirebaseAnalyticsPlugin.h"
#import <CommonCrypto/CommonDigest.h>

@import FirebaseCore;
@import FirebaseAnalytics;

@implementation FirebaseAnalyticsPlugin

- (void)pluginInitialize {
    NSLog(@"Starting Firebase Analytics plugin");

    if(![FIRApp defaultApp]) {
        [FIRApp configure];
    }
}

- (void)logEvent:(CDVInvokedUrlCommand *)command {
    NSString* name = [command.arguments objectAtIndex:0];
    NSDictionary* parameters = [command.arguments objectAtIndex:1];

    [FIRAnalytics logEventWithName:name parameters:parameters];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUserId:(CDVInvokedUrlCommand *)command {
    NSString* id = [command.arguments objectAtIndex:0];

    [FIRAnalytics setUserID:id];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUserProperty:(CDVInvokedUrlCommand *)command {
    NSString* name = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:1];

    [FIRAnalytics setUserPropertyString:value forName:name];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setEnabled:(CDVInvokedUrlCommand *)command {
    bool enabled = [[command.arguments objectAtIndex:0] boolValue];

    [FIRAnalytics setAnalyticsCollectionEnabled:enabled];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setCurrentScreen:(CDVInvokedUrlCommand *)command {
    NSString* screenName = [command.arguments objectAtIndex:0];

    [FIRAnalytics logEventWithName:kFIREventScreenView parameters:@{
        kFIRParameterScreenName: screenName
    }];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)resetAnalyticsData:(CDVInvokedUrlCommand *)command {
    [FIRAnalytics resetAnalyticsData];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setDefaultEventParameters:(CDVInvokedUrlCommand *)command {
    NSDictionary* params = [command.arguments objectAtIndex:0];

    [FIRAnalytics setDefaultEventParameters:params];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initiateOnDeviceConversionMeasurementWithEmail:(CDVInvokedUrlCommand *)command {
    if ([command.arguments count] == 0) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Email address is required"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSString* emailAddress = [command.arguments objectAtIndex:0];
    
    if (![self isValidEmail:emailAddress]) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid email address format"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    [FIRAnalytics initiateOnDeviceConversionMeasurementWithEmailAddress:emailAddress];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initiateOnDeviceConversionMeasurementWithPhoneNumber:(CDVInvokedUrlCommand *)command {
    if ([command.arguments count] == 0) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Phone number is required"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSString* phoneNumber = [command.arguments objectAtIndex:0];
    
    if (![self isValidE164PhoneNumber:phoneNumber]) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid phone number format. Must be in E.164 format (e.g., +15555555555)"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    [FIRAnalytics initiateOnDeviceConversionMeasurementWithPhoneNumber:phoneNumber];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initiateOnDeviceConversionMeasurementWithHashedEmail:(CDVInvokedUrlCommand *)command {
    if ([command.arguments count] == 0) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Email address is required"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSString* emailAddress = [command.arguments objectAtIndex:0];
    
    if (![self isValidEmail:emailAddress]) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid email address format"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSString* normalizedEmail = [self normalizeEmail:emailAddress];
    NSData* hashedEmail = [self sha256:normalizedEmail];
    
    [FIRAnalytics initiateOnDeviceConversionMeasurementWithHashedEmailAddress:hashedEmail];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initiateOnDeviceConversionMeasurementWithHashedPhoneNumber:(CDVInvokedUrlCommand *)command {
    if ([command.arguments count] == 0) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Phone number is required"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSString* phoneNumber = [command.arguments objectAtIndex:0];
    
    if (![self isValidE164PhoneNumber:phoneNumber]) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid phone number format. Must be in E.164 format (e.g., +15555555555)"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    NSData* hashedPhoneNumber = [self sha256:phoneNumber];
    
    [FIRAnalytics initiateOnDeviceConversionMeasurementWithHashedPhoneNumber:hashedPhoneNumber];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSString*)normalizeEmail:(NSString*)email {
    NSString* normalized = [email lowercaseString];
    
    if ([normalized hasSuffix:@"@googlemail.com"]) {
        normalized = [normalized stringByReplacingOccurrencesOfString:@"@googlemail.com" withString:@"@gmail.com"];
    }
    
    if ([normalized hasSuffix:@"@gmail.com"]) {
        NSArray* components = [normalized componentsSeparatedByString:@"@"];
        if ([components count] == 2) {
            NSString* username = components[0];
            
            username = [username stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            username = [username stringByReplacingOccurrencesOfString:@"i" withString:@"l"];
            username = [username stringByReplacingOccurrencesOfString:@"I" withString:@"l"];
            username = [username stringByReplacingOccurrencesOfString:@"1" withString:@"l"];
            username = [username stringByReplacingOccurrencesOfString:@"0" withString:@"o"];
            username = [username stringByReplacingOccurrencesOfString:@"2" withString:@"z"];
            username = [username stringByReplacingOccurrencesOfString:@"5" withString:@"s"];
            
            normalized = [NSString stringWithFormat:@"%@@gmail.com", username];
        }
    }
    
    return normalized;
}

- (BOOL)isValidEmail:(NSString*)email {
    NSString* pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:email];
}

- (BOOL)isValidE164PhoneNumber:(NSString*)phoneNumber {
    NSString* pattern = @"^\\+[0-9]{1,3}[0-9]{1,12}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:phoneNumber];
}

- (NSData*)sha256:(NSString*)string {
    const char* str = [string UTF8String];
    unsigned char result[32];
    CC_SHA256(str, (CC_LONG)strlen(str), result);
    return [NSData dataWithBytes:result length:32];
}

@end
