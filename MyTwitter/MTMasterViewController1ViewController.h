//
//  MTMasterViewController1ViewController.h
//  MyTwitter
//
//  Created by Guest-admin on 2/3/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface MTMasterViewController1ViewController : UITableViewController {
 NSArray *tweets;
 NSMutableArray *num;
 int co;
 int j;
 NSString *username;
 UITextField *textField;
 ACAccountStore *account;
 ACAccountType *accountType;
 NSArray *arrayOfAccounts;
 ACAccount *twitterAccount;
 BOOL whichUrl;
}

- (void)fetchTimeLineTweets:(int) co;

@end

