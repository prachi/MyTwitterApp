//
//  MTWebViewController.m
//  MyTwitter
//
//  Created by Guest-admin on 2/4/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import "MTWebViewController.h"

@interface MTWebViewController ()

@end

@implementation MTWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:[self url]];
    [mywebView loadRequest:myRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
