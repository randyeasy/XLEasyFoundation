
//
//  XLETimer.h
//  Pods
//
//  Created by Randy on 15/12/31.
//
//

#import <Foundation/Foundation.h>

//系统的NSTimer会retain target，导致循环引用，无法释放，所以写一个Timer，它不会retain target

@interface XLETimer : NSObject

+ (XLETimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                     forMode:(NSString *)mode;
- (void)invalidate;

@end
