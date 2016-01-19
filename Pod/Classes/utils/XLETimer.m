
#import "XLETimer.h"
@implementation XLETimer

-(void)time
{
    if ([target respondsToSelector:selector]) {
        [target performSelector:selector];
    }
}

- (void)dealloc
{
    [self invalidate];
}

- (void)invalidate
{
    [self.timer invalidate];
    _timer = nil;
    target = nil;
    selector = nil;
}

+ (XLETimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector forMode:(NSString *)mode
{
    XLETimer* timer = [[XLETimer alloc] init];
    if (timer)
    {
        timer->target = aTarget;
        timer->selector = aSelector;
        timer.timer = [NSTimer timerWithTimeInterval:ti target:timer selector:@selector(time) userInfo:nil repeats:YES];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer.timer forMode:mode];
    }
    return timer;
}
@end
