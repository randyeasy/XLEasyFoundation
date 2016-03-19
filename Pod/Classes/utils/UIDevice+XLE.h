//
//  UIDevice(Identifier).h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XLEDeviceFamily) {
    XLE_DEVICE_UNKONW = 0,
    XLE_DEVICE_IPHONE = 1,
    XLE_DEVICE_IPAD = 2,
    XLE_DEVICE_APPLETV = 3,
    XLE_DEVICE_APPLEWATCH = 4,
};

@interface UIDevice (XLE)

/*
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */

+ (NSString *)XLE_uniqueGlobalDeviceIdentifier;


//获得设备的识别码如"iPhone1,1"，"iPhone1,2"
+ (NSString *)XLE_platformString;


//获得设备的名称，如"iPhone 5(AT&T)"，"iPad Mini (CDMA)"等
+ (NSString* )XLE_platformName;

+ (NSString *)XLE_bundleSeedID;


//是否是性能较差的设备
+ (BOOL)XLE_isLowDevice;

//是否是iphone5的屏幕尺寸
+ (BOOL)XLE_iphone5Screen;

//iOS5及以上
+ (BOOL)XLE_isSystemGreaterIOS5;
+ (BOOL)XLE_isSystemGreaterIOS6;
+ (BOOL)XLE_isSystemGreaterIOS7;
+ (BOOL)XLE_isSystemGreaterIOS8;

+ (XLEDeviceFamily)XLE_deviceFamily;

@end
