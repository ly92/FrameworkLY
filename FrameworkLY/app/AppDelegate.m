//
//  AppDelegate.m
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/15.
//  Copyright © 2017年 ly. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"//网站状态

#import "LYTabBarItem.h"

#import "CaptureViewController.h"

@interface AppDelegate ()<LYTabBarControllerDelegate>

@end

@implementation AppDelegate
@def_singleton(AppDelegate);

+ (AppDelegate*) sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //设置状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //SVProgressHUD默认样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //设置默认弹出时间为1秒
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置根页面，顺带－网络请求配置
    [self setupRootViewController];

    //监测网络状态
    [self moniterNetwork];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark-设置主界面
#pragma mark - 界面
-(void)setupRootViewController{
    if(self.tabController){
        //所有nav显示首页
        for (UIViewController *controller in [self.tabController viewControllers]) {
            if ([controller isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)controller;
                if ([nav viewControllers].count>1) {
                    [nav popToRootViewControllerAnimated:NO];
                }
            }
        }
        //切换到首页
        [self.tabController setSelectedIndex:0];
    }
     [self setupViewControllers];
}

- (void)setupViewControllers {
    CaptureViewController *firVC = [[CaptureViewController alloc] init];
    LYNavigationController *firNav = [[LYNavigationController alloc] initWithRootViewController:firVC];
    
    UIViewController *secVC = [[UIViewController alloc] init];
    LYNavigationController *secNav = [[LYNavigationController alloc] initWithRootViewController:secVC];
    
    UIViewController *thirVC = [[UIViewController alloc] init];
    LYNavigationController *thirNav = [[LYNavigationController alloc] initWithRootViewController:thirVC];
    
    UIViewController *fouVC = [[UIViewController alloc] init];
    LYNavigationController *fouNav = [[LYNavigationController alloc] initWithRootViewController:fouVC];
    
    LYTabBarController *tabBarController = [[LYTabBarController alloc] init];
    [tabBarController setViewControllers:@[firNav,secNav,thirNav,fouNav]];
    
    tabBarController.tabBar.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_tab"]];
    tabBarController.delegate = self;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    line.backgroundColor = COLOR_BG;
    [tabBarController.tabBar addSubview:line];
    
    self.tabController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];

    [self.window setRootViewController:self.tabController];
}

- (void)customizeTabBarForController:(LYTabBarController *)tabBarController {
    
    NSArray *tabBarItemTitles = @[@"采集", @"2",@"3",@"4",@"5"];
    
    NSInteger index = 0;
    for (LYTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //标题
        [item setSelectedTitleAttributes: @{
                                            NSFontAttributeName: [UIFont systemFontOfSize:11],
                                            NSForegroundColorAttributeName: TAB_SELECTTEXT_COLOR,
                                            }];
        
        [item setUnselectedTitleAttributes: @{
                                              NSFontAttributeName: [UIFont systemFontOfSize:11],
                                              NSForegroundColorAttributeName: TAB_TEXT_COLOR,
                                              }];
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        //icon
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"home_tab_icon_%ld_pre",
                                                      index+1]];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"home_tab_icon_%ld",
                                                        index+1]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        
        index++;
    }
}


#pragma mark - 网络监测
-(void)moniterNetwork
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kReachabilityChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        Reachability *reachability = (Reachability *)note.object;
        NetworkStatus status = [reachability currentReachabilityStatus];
        
        if (status == NotReachable)
        {
            NSLog(@"Network unreachable!");
            [SVProgressHUD showErrorWithStatus:@"网络不可用，请检查网络连接"];
        }
        if (status == ReachableViaWiFi)
        {
            NSLog( @"Network wifi! Free!");
        }
        if (status == ReachableViaWWAN)
        {
            NSLog( @"Network WWAN! In charge!");
        }
    }];
    
    [reach startNotifier];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
