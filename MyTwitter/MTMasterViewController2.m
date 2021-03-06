//
//  MTMasterViewController2.m
//  MyTwitter
//
//  Created by Guest-admin on 2/4/14.
//  Copyright (c) 2014 Guest-admin. All rights reserved.
//

#import "MTMasterViewController2.h"
#import "MTDetailViewController1.h"


@interface MTMasterViewController2 () <UIAlertViewDelegate>
@property (nonatomic,strong) UIBarButtonItem *AddTweet;

@end

@implementation MTMasterViewController2

-(void)refreshView:(UIRefreshControl *)refresh {
    //  [self.refreshControl beginRefreshing];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    NSDate *start = [NSDate date];
    [self fetchTimeLineTweets:co];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    int flag=1;
    
    while (flag) {
        NSTimeInterval timeInterval = [start timeIntervalSinceNow];
        if (tweets.count != j || -1*timeInterval > 1)
        {
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            flag = 0;
        }
    }
    
}

- (void)viewDidLoad
{
    co = 0;
    num = [[NSMutableArray alloc] init];
   
    [super viewDidLoad];
    
    [super viewDidLoad];
    account = [[ACAccountStore alloc] init];
    accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if( granted == YES){
            arrayOfAccounts = [account accountsWithAccountType:accountType];
            if ([arrayOfAccounts count] > 0) {
                twitterAccount = [arrayOfAccounts lastObject];
                username = twitterAccount.username;
                [self fetchTimeLineTweets:co];
            }
        }
        else {
            NSLog(@"%@",[error localizedDescription]);
        }
    }];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    self.AddTweet = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(performAddWithAlertView:)];
    [self.navigationItem setRightBarButtonItem:self.AddTweet animated:NO];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:93/255.0 green:202/255.0 blue:249/255.0 alpha:1];
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleSwipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:recognizer];
    

}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    // self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
    
    [self.refreshControl beginRefreshing];
    [self refreshView: nil];
}

- (void)fetchTimeLineTweets:(NSInteger) i
{
    NSURL *requestAPI = [[NSURL alloc] init];
    requestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"100" forKey:@"count"];
    [parameters setObject:@"1" forKey:@"include_entities"];
    SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestAPI parameters:parameters];
    posts.account = twitterAccount;
    [posts performRequestWithHandler:^(NSData *response, NSHTTPURLResponse *urlResponse, NSError *error){
        
        tweets = [[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error] mutableCopy];
        int x = tweets.count;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [num insertObject:[NSNumber numberWithInt:x] atIndex:i];
            co = co+1;
           
            [self.tableView reloadData];
            if (co<=2) {
              //  [self.tableView reloadData];
                
            } else {
                
                j = [[num objectAtIndex:co-2] integerValue];
            }
            
            
        });
        
    }];
    
}

-(NSString *)Tweet{
    return @"Tweet";
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:[self Tweet]]) {
        NSString *newTweet = textField.text;
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:newTweet forKey:@"status"];
        NSString *retweetString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/update.json"];
        NSURL *retweetURL = [NSURL URLWithString:retweetString];
        SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:retweetURL parameters:dict];
        twitterRequest.account = twitterAccount;
        [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([urlResponse statusCode] == 200) {
                    return;
                }
                if (error) {
                    NSLog(@"Error: %@", error.localizedDescription);
                    return;
                }
                
            });
        }];
    }
    
}

-(void) performAddWithAlertView:(id) paramSender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Tweet" message:username delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:[self Tweet],nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput ];
    textField = [alertView textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeAlphabet;
    [alertView show];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   // NSLog(@"%@",tweets);
    if (tweets.count >1){
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    text = [tweet objectForKey:@"text"];
    //NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    
    
    cell.textLabel.text = text;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@", name];
    cell.textLabel.font = [UIFont fontWithName:@"verdana" size:14.0];
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
        

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:data];
        });
    });
       
       return cell;
   }
    
 return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
        NSString *id = [tweet objectForKey:@"id"];
        NSString *delete = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/destroy/%@.json",id];
        NSURL *deleteURL = [NSURL URLWithString:delete];
        SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodDELETE URL:deleteURL parameters:nil];
        twitterRequest.account = twitterAccount;
        [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
         if ([urlResponse statusCode] == 200) {
         return;
         }
         if (error) {
         NSLog(@"Error: %@", error.localizedDescription);
         return;
         }
         
         });
         }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize constraint = CGSizeMake(320 - (10 * 2), 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + 60;
    
}



- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    //Get location of the swipe
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    
    //Get the corresponding index path within the table view
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    //Check if index path is valid
    if(indexPath)
    {
        //Get the cell out of the table view
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        //Update the cell or model
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
    }
    
    MTDetailViewController1 *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail" ];
    NSInteger row = [[self tableView].indexPathForSelectedRow row];
    if (tweets.count>1)
    { NSDictionary *tweet = [tweets objectAtIndex:row];
    controller.detailItem = tweet;
    controller.username = username;
    }
    [self.navigationController pushViewController:controller animated:YES];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   
   if ([segue.identifier isEqualToString:@"ShowMe"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet;
        if (tweets.count >1)
            tweet = [tweets objectAtIndex:row];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        MTDetailViewController1 *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
        detailController.account = twitterAccount;
       detailController.username = username;
       NSLog(@"%@",detailController.username);

        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowMe" sender:self];
    
}



@end

