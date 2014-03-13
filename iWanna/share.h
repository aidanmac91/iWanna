//
//  share.h
//  iWanna
//
//  Created by Aidan on 06/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <Twitter/Twitter.h>
#import <UIKit/UIKit.h>

@interface share : UIViewController
{
    SLComposeViewController *mySLComposerSheet;//used by Twitter and Facebook
}
-(IBAction)shareTwitter:(id)sender;//share tweet
-(IBAction)shareFacebook:(id)sender;//share facebook

@end
