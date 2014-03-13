//
//  ListDetailViewController.h
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iWannaList.h"
#import "IconPickerViewController.h"

@class ListDetailViewController;//tells compiler about the class

@class iWannaList;//tells compiler about the class

@protocol ListDetailViewControllerDelegate <NSObject>//provides class with the following methods

- (void)listDetailViewControllerDidCancel: (ListDetailViewController *)controller;

- (void)listDetailViewController:(ListDetailViewController *)controller
        didFinishAddingChecklist:(iWannaList *)checklist;

- (void)listDetailViewController:(ListDetailViewController *)controller
       didFinishEditingChecklist:(iWannaList *)checklist;
@end

@interface ListDetailViewController : UITableViewController
<UITextFieldDelegate,IconPickerViewControllerDelegate>//allows for passing methods to the UITextFied and IconPickerViewController

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;//icon view

@property (nonatomic, weak) IBOutlet UITextField *textField;//name of item

@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneBarButton;//done button

@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) iWannaList *iwannalistToEdit;//item to edit

- (IBAction)cancel;//cancel pressed

- (IBAction)done;//done pressed
@end