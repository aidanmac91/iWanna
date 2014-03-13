//
//  itemDetailViewController.h
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemDetailViewController;//tells compiler about the class
@class iWannaItem;//tells compiler about the class
@protocol ItemDetailViewControllerDelegate <NSObject>//provides class with the following methods

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(iWannaItem *)item;
- (void)itemDetailViewController:(ItemDetailViewController *)controller
         didFinishEditingItem:(iWannaItem *)item;
@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate>//allows passing methods to the UITextField
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;//done Button
@property (weak, nonatomic) IBOutlet UITextField *textField;//name field
@property (nonatomic, strong) iWannaItem *itemToEdit;//item to edit
@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;//delegate for ItemDetailViewController
@property (nonatomic, weak) IBOutlet UISwitch *switchControl;//for remindMe
@property (nonatomic, weak) IBOutlet UILabel *dueDateLabel;//date selected
@property (nonatomic, weak) IBOutlet UISegmentedControl *priorityLevel;//set priority
- (IBAction)cancel;//cancel methodd
- (IBAction)done;//done method
@end
