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

@end

@implementation XLEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"deviceId %@",[UIDevice xle_uniqueGlobalDeviceIdentifier]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
