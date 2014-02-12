//
//  MTMasterViewController2.h
//  MyTwitter
//
//  Created by Guest-admin on 2/4/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface MTMasterViewController2 : UITableViewController{
    NSMutableArray *tweets;
    NSString *text;
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
