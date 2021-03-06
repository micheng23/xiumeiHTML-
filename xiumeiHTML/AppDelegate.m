//
//  AppDelegate.m
//  xiumeiHTML
//
//  Created by zmxn on 16/7/12.
//  Copyright © 2016年 xiumei. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController * rootVC = [[RootViewController alloc] init];
    UINavigationController * navc = [[UINavigationController alloc]initWithRootViewController:rootVC];  
    self.window.rootViewController  = navc;
    [self.window makeKeyAndVisible];
    
    
    
    UIWindow * window = [[UIApplication sharedApplication]keyWindow] ;
    UIImageView *welcome = [[UIImageView alloc]initWithFrame:window.bounds];
    
    [welcome setImage:[UIImage imageNamed:[self getLaunchImageName]]];
    
    //把背景图放在最上层
    
    [window addSubview:welcome];
    
    [window bringSubviewToFront:welcome];
    
    welcome.alpha = 0.99;//这里alpha的值和下面alpha的值不能设置为相同的，否则动画相当于瞬间执行完，启动页之后动画瞬间消失。这里alpha设为0.99，动画就不会有一闪而过的效果，而是一种类似于静态背景的效果。设为0，动画就相当于是淡入的效果了。
    
    [UIView animateWithDuration:2.0f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        //背景图片
        CGRect frame = welcome.frame;
        frame.origin.x = -SCREEN_WIDTH/2;
        frame.origin.y = -SCREEN_HEIGHT/2;
        frame.size.width = SCREEN_WIDTH * 2;
        frame.size.height = SCREEN_HEIGHT * 2;
        welcome.frame = frame;
        welcome.center = self.window.center;

        welcome.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [welcome removeFromSuperview];
        
    }];
    
    

    return YES;
}


- (NSString *)getLaunchImageName {
    
    CGSize viewSize = [[UIApplication sharedApplication]keyWindow].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
