//
//  NSString+XLEVersion.m
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import "NSString+XLEVersion.h"

@implementation NSString (XLEVersion)

-(NSComparisonResult)XLE_compareToVersion:(NSString *)version{
    NSComparisonResult result;
    
    result = NSOrderedSame;
    
    if(![self isEqualToString:version]){
        NSArray *thisVersion = [self componentsSeparatedByString:@"."];
        NSArray *compareVersion = [version componentsSeparatedByString:@"."];
        
        for(NSInteger index = 0; index < MAX([thisVersion count], [compareVersion count]); index++){
            NSInteger thisSegment = (index < [thisVersion count]) ? [[thisVersion objectAtIndex:index] integerValue] : 0;
            NSInteger compareSegment = (index < [compareVersion count]) ? [[compareVersion objectAtIndex:index] integerValue] : 0;
            
            if(thisSegment < compareSegment){
                result = NSOrderedAscending;
                break;
            }
            
            if(thisSegment > compareSegment){
                result = NSOrderedDescending;
                break;
            }
        }
    }
    
    return result;
}


-(BOOL)XLE_isOlderThanVersion:(NSString *)version{
    return ([self XLE_compareToVersion:version] == NSOrderedAscending);
}

-(BOOL)XLE_isNewerThanVersion:(NSString *)version{
    return ([self XLE_compareToVersion:version] == NSOrderedDescending);
}

-(BOOL)XLE_isEqualToVersion:(NSString *)version{
    return ([self XLE_compareToVersion:version] == NSOrderedSame);
}

-(BOOL)XLE_isEqualOrOlderThanVersion:(NSString *)version{
    return ([self XLE_compareToVersion:version] != NSOrderedDescending);
}

-(BOOL)XLE_isEqualOrNewerThanVersion:(NSString *)version{
    return ([self XLE_compareToVersion:version] != NSOrderedAscending);
}

@end
