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
        /*   int tfollowers = [[(NSDictionary *)tweet objectForKey:@"followers_count"] integerValue];
         int tfollowing = [[(NSDictionary *)tweet objectForKey:@"friends_count"] integerValue];
         int ttweetscount = [[(NSDictionary *)tweet objectForKey:@"statuses_count"] integerValue];
         
         
         tweetscount.text = [NSString stringWithFormat:@"%i", ttweetscount];
         following.text= [NSString stringWithFormat:@"%i", tfollowing];
         followers.text = [NSString stringWithFormat:@"%i", tfollowers]; */
        
        nameLabel.text = text;
        tweetContent.text = name;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                profileImage.image = [UIImage imageWithData:data];
            });
        });
    }
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








