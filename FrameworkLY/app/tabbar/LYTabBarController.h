//
//  LYTabBarController.h
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTabBar.h"

@protocol LYTabBarControllerDelegate;

@interface LYTabBarController : UIViewController <LYTabBarDelegate>

/**
 * The tab bar controller’s delegate object.
 */
@property (nonatomic, weak) id<LYTabBarControllerDelegate> delegate;

/**
 * An array of the root view controllers displayed by the tab bar interface.
 */
@property (nonatomic, copy) IBOutletCollection(UIViewController) NSArray *viewControllers;

/**
 * The tab bar view associated with this controller. (read-only)
 */
@property (nonatomic, readonly) LYTabBar *tabBar;

/**
 * The view controller associated with the currently selected tab item.
 */
@property (nonatomic, weak) UIViewController *selectedViewController;

/**
 * The index of the view controller associated with the currently selected tab item.
 */
@property (nonatomic) NSUInteger selectedIndex;

/**
 * A Boolean value that determines whether the tab bar is hidden.
 */
@property (nonatomic, getter=isTabBarHidden) BOOL tabBarHidden;

/**
 * Changes the visibility of the tab bar.
 */
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

@protocol LYTabBarControllerDelegate <NSObject>
@optional
/**
 * Asks the delegate whether the specified view controller should be made active.
 */
- (BOOL)tabBarController:(LYTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

/**
 * Tells the delegate that the user selected an item in the tab bar.
 */
- (void)tabBarController:(LYTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@interface UIViewController (LYTabBarControllerItem)

/**
 * The tab bar item that represents the view controller when added to a tab bar controller.
 */
@property(nonatomic, setter = ly_setTabBarItem:) LYTabBarItem *ly_tabBarItem;

/**
 * The nearest ancestor in the view controller hierarchy that is a tab bar controller. (read-only)
 */
@property(nonatomic, readonly) LYTabBarController *ly_tabBarController;

@end
