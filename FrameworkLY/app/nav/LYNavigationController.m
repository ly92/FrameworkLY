//
//  LYNavigationController.m
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#import "LYNavigationController.h"
#import "LYBlackTransition.h"

@interface LYNavigationController ()

@end

@implementation LYNavigationController

+ (void)load{
    [LYBlackTransition validatePanPackWithLYBlackTransitionGestureRecognizerType:LYBlackTransitionGestureRecognizerTypePan class:self];
}

@end
