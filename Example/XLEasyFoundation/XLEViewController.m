//
//  XLEViewController.m
//  XLEasyFoundation
//
//  Created by 闫晓亮 on 01/19/2016.
//  Copyright (c) 2016 闫晓亮. All rights reserved.
//

#import "XLEViewController.h"
#import <XLEasyFoundation/XLEasyFoundation.h>

@interface XLEViewController ()
@property (strong, nonatomic) XLEAction *actin;
@property (strong, nonatomic) XLEAction *noSubPathActin;
@end

@implementation XLEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"deviceId %@",[UIDevice XLE_uniqueGlobalDeviceIdentifier]);
}

- (void)doAddItemsOperation{
    [super doAddItemsOperation];
    
    XLEActionContext *context = [XLEActionContext contextWithSourceType:XLE_ACTION_SOURCE_NATIVE navi:self.navigationController];
    
    [self.actin addListenerWithName:@"testAction" handle:^BOOL(XLEActionContext * _Nullable navi, NSDictionary * _Nonnull payload, XLEActionHandlerCallback  _Nullable callback) {
        if (callback) {
            callback(@{@"callKey":@"callValue"});
        }
        return YES;
    }];
    
    [self.noSubPathActin addListenerWithName:@"testAction" handle:^BOOL(XLEActionContext * _Nullable navi, NSDictionary * _Nonnull payload, XLEActionHandlerCallback  _Nullable callback) {
        if (callback) {
            callback(@{@"noSubPathcallKey":@"noSubPathcallValue"});
        }
        return YES;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - set get
- (XLEAction *)actin{
    if (_actin == nil) {
        _actin = [[XLEAction alloc] initWithScheme:@"app" host:@"test.com" subPath:@"test"];
    }
    return _actin;
}

- (XLEAction *)noSubPathActin{
    if (_noSubPathActin == nil) {
        _noSubPathActin = [[XLEAction alloc] initWithScheme:@"app" host:@"test.com" subPath:nil];
    }
    return _noSubPathActin;
}

@end
