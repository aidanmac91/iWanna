//
//  IconPickerViewController.h
//  iWanna
//
//  Created by Aidan on 02/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;//tells compiler about the class

@protocol IconPickerViewControllerDelegate <NSObject>

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName;//gets name of icon picked

@end

@interface IconPickerViewController : UITableViewController

@property (nonatomic, weak) id <IconPickerViewControllerDelegate> delegate;

@end