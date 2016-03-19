//
//  UIDevice(Identifier).m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UIDevice+XLE.h"
#import "XLEKeychain.h"
#import "NSString+XLEMD5.h"
#import <Security/Security.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (XLE)

#pragma mark -
#pragma mark Public Methods
+ (NSString *)XLE_uniqueGlobalDeviceIdentifier{
    return [UIDevice XLE_getUUIDFromKeyChain];
}

//对应的 AppIdentifierPrefix
+ (NSString *)XLE_bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)(kSecClassGenericPassword), kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

+ (NSString *)XLE_getUUIDFromKeyChain
{
    NSString *keyChainIdentifier = @"XLEUUID";
    NSString *keyChainService = @"com.XLE.XLEasy";
    
    NSString *keyChainGroup = [NSString stringWithFormat:@"%@.family", [UIDevice XLE_bundleSeedID] ];
    NSString *retrieveuuid = [XLEKeychain passwordForService:keyChainService account:keyChainIdentifier accessGroup:keyChainGroup];
    
    if (retrieveuuid==nil||[retrieveuuid isEqualToString:@""])
    {
        NSString *did = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [XLEKeychain setPassword:did
                     forService:keyChainService account:keyChainIdentifier accessGroup:keyChainGroup];
        return did;
    }
    else
    {
        return retrieveuuid;
    }
}

+ (NSString *)XLE_platformString
{
    size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
	free(machine);
    return platform;
}

+ (NSString* )XLE_platformName
{
    size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *deviceString = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
	free(machine);

    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (Global)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    //iPod Touch
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPod7,1"])      return @"iPod touch 6G"; // as 6,1 was never released 7,1 is actually 6th generation

    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (Wi-Fi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (Wi-Fi)";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini 1G (Wi-Fi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini 1G (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini 1G (Global)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (Wi-Fi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2G (Cellular)"; // TD-LTE model see https://support.apple.com/en-us/HT201471#iPad-mini2
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad mini 3G (Wi-Fi)";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad mini 3G (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3G (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV1,1"])      return @"Apple TV 1G";
    if ([deviceString isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2G";
    if ([deviceString isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3G";
    if ([deviceString isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3G"; // small, incremental update over 3,1
    if ([deviceString isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4G";
    
    //Simulator
    if ([deviceString isEqualToString:@"i386"] || [deviceString hasSuffix:@"86"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return @"unknow";
}

+ (BOOL)XLE_isLowDevice
{
    size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *deviceString = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
	free(machine);
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return YES;
    if ([deviceString isEqualToString:@"iPhone1,2"])    return YES;
    if ([deviceString isEqualToString:@"iPhone2,1"])    return YES;
    if ([deviceString isEqualToString:@"iPhone3,1"])    return YES;
    if ([deviceString isEqualToString:@"iPhone3,2"])    return YES;
    //if ([deviceString isEqualToString:@"iPhone4,1"])    return NO;
    //if ([deviceString isEqualToString:@"iPhone5,1"])    return NO;
    //if ([deviceString isEqualToString:@"iPhone5,2"])    return NO;
    //iPod Touch
    if ([deviceString isEqualToString:@"iPod1,1"])      return YES;
    if ([deviceString isEqualToString:@"iPod2,1"])      return YES;
    if ([deviceString isEqualToString:@"iPod3,1"])      return YES;
    if ([deviceString isEqualToString:@"iPod4,1"])      return YES;
    //if ([deviceString isEqualToString:@"iPod5,1"])      return NO;
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return YES;
    if ([deviceString isEqualToString:@"iPad2,1"])      return YES;
    if ([deviceString isEqualToString:@"iPad2,2"])      return YES;
    if ([deviceString isEqualToString:@"iPad2,3"])      return YES;
    //if ([deviceString isEqualToString:@"iPad2,5"])      return NO;
    //if ([deviceString isEqualToString:@"iPad2,6"])      return NO;
    //if ([deviceString isEqualToString:@"iPad2,7"])      return NO;
    if ([deviceString isEqualToString:@"iPad3,1"])      return YES;
    if ([deviceString isEqualToString:@"iPad3,2"])      return YES;
    if ([deviceString isEqualToString:@"iPad3,3"])      return YES;
    //if ([deviceString isEqualToString:@"iPad3,4"])      return NO;
    //if ([deviceString isEqualToString:@"iPad3,5"])      return NO;
    //if ([deviceString isEqualToString:@"iPad3,6"])      return NO;
    //Simulator
    //if ([deviceString isEqualToString:@"i386"])         return NO;
    //if ([deviceString isEqualToString:@"x86_64"])       return NO;
    
    return NO;
}

+ (BOOL)XLE_iphone5Screen
{
    //UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize si = [UIScreen mainScreen].bounds.size;
        if (si.width == 320 && si.height == 568)
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)XLE_isSystemGreaterIOS5;
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version >= 5.0f;
}
+ (BOOL)XLE_isSystemGreaterIOS6;
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version >= 6.0f;
}
+ (BOOL)XLE_isSystemGreaterIOS7;
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version >= 7.0f;
}
+ (BOOL)XLE_isSystemGreaterIOS8;
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version >= 8.0f;
}

+ (XLEDeviceFamily)XLE_deviceFamily
{
    NSString *modelIdentifier = [self XLE_platformString];
    if ([modelIdentifier hasPrefix:@"iPhone"] || [modelIdentifier hasPrefix:@"iPod"]) return XLE_DEVICE_IPHONE;
    if ([modelIdentifier hasPrefix:@"AppleWatch"]) return XLE_DEVICE_APPLEWATCH;
    if ([modelIdentifier hasPrefix:@"iPad"]) return XLE_DEVICE_IPAD;
    if ([modelIdentifier hasPrefix:@"AppleTV"]) return XLE_DEVICE_APPLETV;
    return XLE_DEVICE_UNKONW;
}

@end
