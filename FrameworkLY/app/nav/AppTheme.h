//
//  AppTheme.h
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  定义各个页面所用到的字体及颜色 以及段落样式
 */
@interface AppTheme : NSObject
@singleton( AppTheme )

+ (UIColor *)mainColor;
+ (UIColor *)titleColor;
+ (UIColor *)subTitleColor;
+ (UIColor *)bgColor;
+ (UIColor *)lineColor;

#pragma mark - Line

+ (CGFloat)onePixel;

#pragma mark - UITabBarItem

+ (UITabBarItem *)itemWithImageName:(NSString *)imageName selectImageName:(NSString *)selectImageName title:(NSString *)title;

#pragma mark - UINavigationBarItem

+ (UIBarButtonItem *)itemWithContent:(id)content handler:(void (^)(id sender))handler;
+ (UIBarButtonItem *)backItemWithHandler:(void (^)(id sender))handler;

+ (NSMutableAttributedString *)timelineNameButtonwithName:(NSString *)name font:(CGFloat)font;

+ (NSMutableAttributedString *)attributedStringWithStr:(NSString *)str
                                                ranges:(NSArray *)ranges;


@end
