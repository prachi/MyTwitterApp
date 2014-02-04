//
//  MTWebViewController.h
//  MyTwitter
//
//  Created by Guest-admin on 2/4/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTWebViewController : UIViewController{
    IBOutlet UIWebView *mywebView;
    
}
@property (strong,nonatomic) NSURL *url;

@end

