//
//  AllListsViewController.h
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iWannaList.h"
#import "iWannaList.h"
#import "ListDetailViewController.h"
#import "DataModel.h"
@class DataModel;//tells compiler about the class


@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>//allows passing methods to the UINavigationController and ListDetailViewController

@property (nonatomic, strong) DataModel *dataModel;
@end
