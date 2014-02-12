//
//  MTDetailViewController1.h
//  MyTwitter
//
//  Created by Guest-admin on 2/3/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface MTDetailViewController1 : UIViewController <UIAlertViewDelegate> {
   
    IBOutlet UITextView *tweetContent;
  //  IBOutlet UITextView *tweetContent;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profileImage;
   
}

@property (strong, nonatomic) IBOutlet UIButton *delete;

@property (strong, nonatomic) id detailItem;
@property (strong,nonatomic) ACAccount *account;
@property (strong, nonatomic) NSString *username;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end