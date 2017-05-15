//
//  LYBlackTransition.h
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LYBlackTransitionGestureRecognizerTypePan, //拖动模式
    LYBlackTransitionGestureRecognizerTypeScreenEdgePan, //边界拖动模式
} LYBlackTransitionGestureRecognizerType;


@interface LYBlackTransition : NSObject
+ (void)validatePanPackWithLYBlackTransitionGestureRecognizerType:(LYBlackTransitionGestureRecognizerType)type class:(Class)clazz;
@end

@interface UIView(__LYBlackTransition)

//使得此view不响应拖返
@property (nonatomic, assign) BOOL disableLYBlackTransition;

@end

@interface UINavigationController(DisableLYBlackTransition)

- (void)enabledLYBlackTransition:(BOOL)enabled;

@end
