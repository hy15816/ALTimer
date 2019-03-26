//
//  ALTimer.h
//  CocoapodsTest
//
//  Created by Lost-souls on 2019/3/26.
//  Copyright © 2019年 Lost-souls. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ALTimerBlock)(id userInfo);


@interface ALTimer : NSObject


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(ALTimerBlock)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(ALTimerBlock)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats
                                     inMode:(NSRunLoopMode)mode;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats
                                     inMode:(NSRunLoopMode)mode;

@end

NS_ASSUME_NONNULL_END
