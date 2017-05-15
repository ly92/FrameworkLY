//
//  LYTabBar.h
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYTabBar, LYTabBarItem;

@protocol LYTabBarDelegate <NSObject>

/**
 * Asks the delegate if the specified tab bar item should be selected.
 */
- (BOOL)tabBar:(LYTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index;

/**
 * Tells the delegate that the specified tab bar item is now selected.
 */
- (void)tabBar:(LYTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;

@end

@interface LYTabBar : UIView

/**
 * The tab bar’s delegate object.
 */
@property (nonatomic, weak) id <LYTabBarDelegate> delegate;

/**
 * The items displayed on the tab bar.
 */
@property (nonatomic, copy) NSArray *items;

/**
 * The currently selected item on the tab bar.
 */
@property (nonatomic, weak) LYTabBarItem *selectedItem;

/**
 * backgroundView stays behind tabBar's items. If you want to add additional views,
 * add them as subviews of backgroundView.
 */
@property (nonatomic, readonly) UIView *backgroundView;

/*
 * contentEdgeInsets can be used to center the items in the middle of the tabBar.
 */
@property UIEdgeInsets contentEdgeInsets;

/**
 * Sets the height of tab bar.
 */
- (void)setHeight:(CGFloat)height;

/**
 * Returns the minimum height of tab bar's items.
 */
- (CGFloat)minimumContentHeight;

/*
 * Enable or disable tabBar translucency. Default is NO.
 */
@property (nonatomic, getter=isTranslucent) BOOL translucent;

@end
