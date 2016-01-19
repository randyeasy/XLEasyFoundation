//
//  SSKeychain.m
//  SSKeychain
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "XLEKeychain.h"

NSString *const kXLEKeychainErrorDomain = @"com.samsoffes.sskeychain";
NSString *const kXLEKeychainAccountKey = @"acct";
NSString *const kXLEKeychainCreatedAtKey = @"cdat";
NSString *const kXLEKeychainClassKey = @"labl";
NSString *const kXLEKeychainDescriptionKey = @"desc";
NSString *const kXLEKeychainLabelKey = @"labl";
NSString *const kXLEKeychainLastModifiedKey = @"mdat";
NSString *const kXLEKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
	static CFTypeRef XLEKeychainAccessibilityType = NULL;
#endif

@implementation XLEKeychain

+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account accessGroup:(NSString *) accessGroup{
	return [self passwordForService:serviceName account:account accessGroup:accessGroup error:nil];
}


+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account accessGroup:(NSString *) accessGroup error:(NSError *__autoreleasing *)error {
	XLEKeychainQuery *query = [[XLEKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
    query.accessGroup  = accessGroup;
	[query fetch:error];
	return query.password;
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account accessGroup:(NSString *) accessGroup {
	return [self deletePasswordForService:serviceName account:account accessGroup:accessGroup error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account accessGroup:(NSString *) accessGroup error:(NSError *__autoreleasing *)error {
	XLEKeychainQuery *query = [[XLEKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
    query.accessGroup = accessGroup;
	return [query deleteItem:error];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account accessGroup:(NSString *) accessGroup{
	return [self setPassword:password forService:serviceName account:account accessGroup:accessGroup error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account  accessGroup:(NSString *) accessGroup error:(NSError *__autoreleasing *)error {
	XLEKeychainQuery *query = [[XLEKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	query.password = password;
    query.accessGroup = accessGroup;
	return [query save:error];
}


+ (NSArray *)allAccounts {
	return [self accountsForService:nil];
}


+ (NSArray *)accountsForService:(NSString *)serviceName {
	XLEKeychainQuery *query = [[XLEKeychainQuery alloc] init];
	query.service = serviceName;
	return [query fetchAll:nil];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
	return XLEKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
	CFRetain(accessibilityType);
	if (XLEKeychainAccessibilityType) {
		CFRelease(XLEKeychainAccessibilityType);
	}
	XLEKeychainAccessibilityType = accessibilityType;
}
#endif

@end
