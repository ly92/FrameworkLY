//
//  AppDelegate.h
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) LYTabBarController *tabController;

@end

