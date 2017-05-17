//
//  Macros.h
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//单例
#undef  singleton
#define singleton( __class ) \
property (nonatomic, readonly) __class * sharedInstance; \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef  def_singleton
#define def_singleton( __class ) \
dynamic sharedInstance; \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __strong id __singleton__ = nil; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

/**
 *屏幕宽高
 *
 */
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  系统版本
 *
 */
#define IOS_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define GT_IOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9
#define GT_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8
#define GT_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
#define GT_IOS6 [[[UIDevice currentDevice] systemVersion] floatValue] >= 6
#define GT_IOS5 [[[UIDevice currentDevice] systemVersion] floatValue] >= 5


/**
 *  颜色
 *
 */
#define COLORWITHRGB(red,green,blue,alpha) [UIColor colorWithRed:((float)(red))/255.0f green:((float)(green))/255.0f blue:((float)(blue))/255.0f alpha:((float)(alpha))]

#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]

#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

//隐藏tabbar
#define HIDETABBAR if (![AppDelegate sharedAppDelegate].tabController.tabBarHidden) {\
[[AppDelegate sharedAppDelegate].tabController setTabBarHidden:YES animated:YES];\
}
//显示tabbar
#define SHOWTABBAR if ([AppDelegate sharedAppDelegate].tabController.tabBarHidden) {\
[[AppDelegate sharedAppDelegate].tabController setTabBarHidden:NO animated:YES];\
}

//隐藏导航栏
#define HIDENAVGATION [self.navigationController setNavigationBarHidden:YES];
//隐藏导航栏
#define SHOWNAVGATION [self.navigationController setNavigationBarHidden:NO];

//下方tabbar背景颜色
#define TAB_BG_COLOR UIColorFromRGB(0xffffff)
//tabbar字体颜色
#define TAB_TEXT_COLOR UIColorFromRGB(0x513a3a)
#define TAB_SELECTTEXT_COLOR UIColorFromRGB(0x5077aa)
//导航栏颜色
#define NAV_COLOR UIColorFromRGB(0x5077aa)
//背景色（240灰色）
#define COLOR_BG RGBCOLOR(240,240,240)
#pragma mark-字体蓝色
#define TEXT_BLUE UIColorFromRGB(0x4B6E99)//
//字体黑色
#define TEXT_BLACK UIColorFromRGB(0x1F2124)
//字体灰色
#define TEXT_GRAY UIColorFromRGB(0x999999)



#endif /* Macros_h */
