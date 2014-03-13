//
//  iWannaViewController.h
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iWannaItem.h"
#import "iWannaList.h"
#import "ItemDetailViewController.h"
@class iWannaList;

@interface iWannaViewController : UITableViewController <ItemDetailViewControllerDelegate>//pass methods to the ItemDetailViewController

@property (nonatomic, strong) iWannaList *list;//list of items
@property int numberOfHigh;
@end
