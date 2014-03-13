//
//  share.m
//  iWanna
//
//  Created by Aidan on 06/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "share.h"

@interface share ()

@end

@implementation share

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];//sets background colour
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//sets color of settings/+ to white
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];//sets colour of title to white
    self.navigationController.navigationBar.translucent = NO;//set traslucent to false
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;//status bar to white
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 share tweet
 */
-(IBAction)shareTwitter:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])//is available
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"I love iWanna!!!!!"];//text of post
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else//no account/internet
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alertView show];
    }
}


/*
 share via facebook
 */
-(IBAction)shareFacebook:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])//is available
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:@"I love iWanna!!!!!"];//text
        [self presentViewController:controller animated:YES completion:Nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry"message:@"You can't send a post right now, make sure your device has an internet connection and you have at least one Facebook account setup" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alertView show];
    }
}
@end
