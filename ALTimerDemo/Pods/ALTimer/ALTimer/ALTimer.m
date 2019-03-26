//
//  ALTimer.m
//  CocoapodsTest
//
//  Created by Lost-souls on 2019/3/26.
//  Copyright © 2019年 Lost-souls. All rights reserved.
//

#import "ALTimer.h"

@interface ALTimerInfo : NSObject

@property (nonatomic, strong) id userInfo;
@property (nonatomic, strong) NSRunLoopMode runLoopMode;

@end

@implementation ALTimerInfo
@end

@interface ALTimer ()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ALTimer

- (void)startTimer:(NSTimer *)timer {
    
    if (self.target) {
        id userInfo = timer.userInfo;
        NSRunLoopMode mode = NSDefaultRunLoopMode;
        if ([timer.userInfo isKindOfClass:[ALTimerInfo class]]) {
            userInfo = [(ALTimerInfo *)timer.userInfo userInfo];
            mode = [(ALTimerInfo *)timer.userInfo runLoopMode];
        }
    }else{
        [self.timer invalidate];
    }
    
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats{
    
    return [self scheduledTimerWithTimeInterval:interval target:aTarget selector:aSelector userInfo:userInfo repeats:repeats inMode:NSDefaultRunLoopMode];
    
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(ALTimerBlock)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats{
    
    return [self scheduledTimerWithTimeInterval:interval block:block userInfo:userInfo repeats:repeats inMode:NSDefaultRunLoopMode];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(ALTimerBlock)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats
                                     inMode:(NSRunLoopMode)mode{
    NSMutableArray *userInfos = [NSMutableArray arrayWithObject:[block copy]];
    if (userInfo != nil) {
        [userInfos addObject:userInfo];
    }
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(timeBlockInvoke:) userInfo:userInfo repeats:repeats inMode:mode];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats
                                     inMode:(NSRunLoopMode)mode{
    
    ALTimer *alTime = [[ALTimer alloc] init];
    alTime.target = aTarget;
    alTime.selector = aSelector;
    
    ALTimerInfo *info = [[ALTimerInfo alloc] init];
    info.userInfo = userInfo;
    info.runLoopMode = mode;
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:alTime selector:@selector(startTimer:) userInfo:info repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:mode];
    
    alTime.timer = timer;
    
    return alTime.timer;
}

+ (void)timeBlockInvoke:(NSArray *)userInfo{
    
    ALTimerBlock block = userInfo.firstObject;
    id info = nil;
    if (userInfo.count == 2) {
        info = userInfo.lastObject;
    }
    if (block) {
        block(info);
    }
}

@end
