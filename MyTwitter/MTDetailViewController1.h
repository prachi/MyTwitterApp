//
//  MTDetailViewController1.h
//  MyTwitter
//
//  Created by Guest-admin on 2/3/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDetailViewController1 : UIViewController{
   
    IBOutlet UITextView *tweetContent;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profileImage;
}


@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end