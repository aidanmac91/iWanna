//
//  itemDetailViewController.m
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "iWannaItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController
{
    NSDate *_dueDate;//date and time for reminder
    BOOL _datePickerVisible;//is date picker visable
}

/*
 initialiser
 */
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
    
    
    if (self.itemToEdit != nil)//item to edit
    {
        self.title = @"Edit Item";//sets title
        self.textField.text = self.itemToEdit.text;//sets name of item
        self.doneBarButton.enabled = YES;//enables done button
        self.switchControl.on = self.itemToEdit.shouldRemind;//sets switch to shouldRemind
        _dueDate = self.itemToEdit.dueDate;//sets date to date
        
        ///passes in the priority (0,1,2) as string and converts to int
        NSInteger myInt = [self.itemToEdit.priority intValue];
        self.priorityLevel.selectedSegmentIndex =myInt;//sets priority to myInt value
        
    }
    else//no item to load
    {
        self.switchControl.on = NO;//set control to off
        _dueDate = [NSDate date];//sets date to today
    }
    self.switchControl.onTintColor=[UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];
    self.priorityLevel.tintColor=[UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];
    [self updateDueDateLabel];//calls updateDueDateLabel
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 Cancel is pressed
 */
- (IBAction)cancel
{
    [self.delegate itemDetailViewControllerDidCancel:self];//calls the itemDetailViewControllerDidCancel function
}

/*
 Done is pressed
 */
- (IBAction)done
{
    if (self.itemToEdit == nil)//add new item
    {
        iWannaItem *item = [[iWannaItem alloc] init];//inits item
        item.text = self.textField.text;//sets text to textfield
        item.checked = NO;//not checked
        item.shouldRemind = self.switchControl.on;//sets remind if selected
        item.dueDate = _dueDate;//set dueDate to _dueDate
        NSInteger p=[_priorityLevel selectedSegmentIndex];//gets index
        NSString *inStr = [NSString stringWithFormat: @"%d", (int)p];//converts to string
        item.priority=inStr;//sets priority to inStr
        [item scheduleNotification];//calls scheduleNotification
        
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];//calls didFinishAddingItem method
    }
    else//edit existing item
    {
        self.itemToEdit.text = self.textField.text;//sets text to textfield
        self.itemToEdit.shouldRemind = self.switchControl.on;//sets remind if selected
        self.itemToEdit.dueDate = _dueDate;//set dueDate to _dueDate
        [self.itemToEdit scheduleNotification];//calls scheduleNotification
        NSInteger p=[_priorityLevel selectedSegmentIndex];//gets index
        NSString *inStr = [NSString stringWithFormat: @"%d", (int)p];//converts to string
        self.itemToEdit.priority=inStr;//sets priority to inStr
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];//calls didFinishEditingItem
    }
    
}

/*
 Checks if row can be selected
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1)//can select
    {
        return indexPath;
    }
    else//cant select
    {
        return nil;
    }
}

/*
 makes text field the active component
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

/*
 when text is entered
 */
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text
                         stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);//enables done if text is entered
    return YES;
}

/*
 converts date to text
 */
- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:_dueDate];
}

/*
 Displays datePicker 
 As per the tutorial "CheckList"
 */
- (void)showDatePicker
{
    
    NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
    _datePickerVisible = YES;
    NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
    cell.detailTextLabel.textColor =cell.detailTextLabel.tintColor;
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    UITableViewCell *datePickerCell = [self.tableView cellForRowAtIndexPath:indexPathDatePicker];
    UIDatePicker *datePicker = (UIDatePicker *)
    [datePickerCell viewWithTag:100];
    [datePicker setDate:_dueDate animated:NO];
}

/*
 asks data source for cell when displaying particular row
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DatePickerCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 216.0f)];
            datePicker.tag = 100;
            [cell.contentView addSubview:datePicker];
            [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        }
        return cell;
    }
    else
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}


/*
 gets number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 && _datePickerVisible)
    {
        return 3;
    }
    else
    {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

/*
 gives each cell its own height
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2)
    {
        return 217.0f;
    }
    else
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        
    }
}

/*
  called if cell is pressed
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.textField resignFirstResponder];//not target anymore
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        if (!_datePickerVisible)
        {
            
            [self showDatePicker];//shows datepicker
            
        }
        else
        {
            
            [self hideDatePicker];//hides date picker
            
        }
    }
}

/*
 Used because we are using static cells and data source
 As per the tuturiol "CheckList"
 */
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2)
    {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        return [super tableView:tableView indentationLevelForRowAtIndexPath:newIndexPath];
    }
    else
    {
        return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
}

/*
 called when date is changed
 */
- (void)dateChanged:(UIDatePicker *)datePicker
{
    _dueDate = datePicker.date;
    [self updateDueDateLabel];
}

/*
 hides DatePicker
 deletes the date picker cell from the table view
 */
- (void)hideDatePicker
{
    if (_datePickerVisible)
    {
        _datePickerVisible = NO;
        NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
        NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow]
                              withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView                                                                              deleteRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

/*
 hides the date picker
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self hideDatePicker];
}


@end
