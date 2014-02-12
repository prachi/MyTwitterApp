//
//  MTDetailViewController1.m
//  MyTwitter
//
//  Created by Guest-admin on 2/3/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import "MTDetailViewController1.h"

@interface MTDetailViewController1 ()
- (void)configureView;
@end


@implementation MTDetailViewController1

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        NSDictionary *tweet = self.detailItem;
        
        NSString *text = [[tweet objectForKey:@"user"] objectForKey:@"name"];
        NSString *name = [tweet objectForKey:@"text"];
        nameLabel.text = text;
        tweetContent.text = name;
        [tweetContent scrollRangeToVisible:NSMakeRange([tweetContent.text length], 0)];
       
        UIButton *retweet = [UIButton buttonWithType:UIButtonTypeRoundedRect ];
        [retweet setTintColor:[UIColor blackColor]];
        [retweet setTitle:@"retweet" forState:UIControlStateNormal];
        [retweet addTarget:self action:@selector(retweet:) forControlEvents:UIControlEventTouchUpInside];
        retweet.frame = CGRectMake(120, 300, 80, 40);
        [self.view addSubview:retweet];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                profileImage.image = [UIImage imageWithData:data];
            });
        });
    }
}

-(void)retweet:(id)sender{
    NSDictionary *tweet = self.detailItem;
    NSString *id = [tweet objectForKey:@"id"];
    NSString *retweet = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json",id];
    NSURL *retweetURL = [NSURL URLWithString:retweet];
    SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:retweetURL parameters:nil];
    twitterRequest.account = self.account;
    [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([urlResponse statusCode] == 200) {
                return;
            }
            else if (error) {
                NSLog(@"Error: %@", error.localizedDescription);
                return;
            }
            else if ([urlResponse statusCode] == 403)
                NSLog(@"its yr profile dude");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Retweeted by you" message:twitterRequest.account.username delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
            [alertView show];
            
        });
    }];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
   	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end








