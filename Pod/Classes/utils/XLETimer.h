
#import <Foundation/Foundation.h>
//系统的NSTimer会retain target，导致循环引用，无法释放，所以写一个Timer，它不会retain target
@interface XLETimer : NSObject
{
    __weak id target;
    SEL selector;
    
}
@property (nonatomic,strong)NSTimer* timer;
+ (XLETimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector forMode:(NSString *)mode;
- (void)invalidate;
@end
