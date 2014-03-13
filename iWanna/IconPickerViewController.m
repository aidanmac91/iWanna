//
//  IconPickerViewController.m
//  iWanna
//
//  Created by Aidan on 02/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController
{
    NSArray *_icons;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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

    _icons = @[//list of icons
               @"No Icon",
               @"Appointments",
               @"Birthdays",
               @"Chores",
               @"Drinks",
               @"Folder",
               @"Groceries",
               @"Inbox",
               @"Photos",
               @"Trips"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 gets number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_icons count];
}

/*
 asks data source for cell when displaying particular row
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    NSString *icon = _icons[indexPath.row];
    cell.textLabel.text = icon;//set name
     cell.textLabel.textColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];
    cell.imageView.image = [UIImage imageNamed:icon];//sets icon
    return cell;
}

/*
 get row selected
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = _icons[indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
