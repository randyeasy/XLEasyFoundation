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
    NSLog(@"deviceId %@",[UIDevice xle_uniqueGlobalDeviceIdentifier]);
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
    
    [self.items addObject:[XLEDemoItem itemWithName:@"action" desc:@"app://test.com/test/testAction host为test.com subPath为test" callback:^{
        BOOL result = [self.actin handleOpenUrl:@"app://test.com/test/testAction" withPayload:@{@"testKey":@"testValue"} context:context callback:^(NSDictionary * _Nonnull callbackPayload) {
            [self showDemoResultString:[NSString stringWithFormat:@"action 回调 callbackPayload:%@",callbackPayload]];
        }];
        [self showDemoResultString:[NSString stringWithFormat:@"action 结果 result:%d",result]];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"action" desc:@"app://test.com/testAction subPath对应不上，不会响应" callback:^{
        BOOL result = [self.actin handleOpenUrl:@"app://test.com/testAction" withPayload:@{@"testKey":@"testValue"} context:context callback:^(NSDictionary * _Nonnull callbackPayload) {
            [self showDemoResultString:[NSString stringWithFormat:@"action 回调 callbackPayload:%@",callbackPayload]];
        }];
        [self showDemoResultString:[NSString stringWithFormat:@"action 结果 result:%d",result]];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"action" desc:@"app://test.com/testAction 测试没有subPath的action能否正常响应" callback:^{
        BOOL result = [self.noSubPathActin handleOpenUrl:@"app://test.com/testAction" withPayload:@{@"testKey":@"testValue"} context:context callback:^(NSDictionary * _Nonnull callbackPayload) {
            [self showDemoResultString:[NSString stringWithFormat:@"action 回调 callbackPayload:%@",callbackPayload]];
        }];
        [self showDemoResultString:[NSString stringWithFormat:@"action 结果 result:%d",result]];
    }]];
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
