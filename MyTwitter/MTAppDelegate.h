//
//  MTAppDelegate.h
//  MyTwitter
//
//  Created by Guest-admin on 2/3/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController1,*navigationController2;
@property (strong, nonatomic) UITabBarController *tabBarController;

- (BOOL) openURL:(NSURL *)url;
@end






