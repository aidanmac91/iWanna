//
//  ListDetailViewController.m
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "ListDetailViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
{
    NSString *_iconName;//name of the icon
}

/*
 loads from plist
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        _iconName = @"Folder";//sets icon to Folder
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];//sets background colour
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//sets color of settings/+ to white
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];//sets colour of title to white
    self.navigationController.navigationBar.translucent = NO;//set traslucent to false
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;//status bar to white
    
    if (self.iwannalistToEdit != nil)
    {
        self.title = @"Edit iWannaList";//set name of controller
        self.textField.text = self.iwannalistToEdit.name;//sets text field to the name of the list
        self.doneBarButton.enabled = YES;//sets doneBarButton to enabled
        _iconName = self.iwannalistToEdit.iconName;//sets _iconName to the list's icon
    }
    
    self.iconImageView.image = [UIImage imageNamed:_iconName];//sets view to the icon
}

/*
 preparing for view to appear
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];//sets textField as target
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 cancel button is pressed
 */
- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];//calls method
}

/*
 done is pressed
 */
- (IBAction)done
{
    if (self.iwannalistToEdit == nil)//new list
    {
        iWannaList *checklist = [[iWannaList alloc] init];//initialised list
        checklist.name = self.textField.text;//sets name
        checklist.iconName = _iconName;//sets icon
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];//calls didFinishAddingCheckList method
    }
    else//editing existing list
    {
        self.iwannalistToEdit.name = self.textField.text;//sets text
        self.iwannalistToEdit.iconName = _iconName;//sets icon
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.iwannalistToEdit];//calls didFinishEditingCheckList method
    }
}

/*
 can row be selected
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)//yes
    {
        return indexPath;
    }
    else//no
    {
        return nil;
    }
}

/*
 enables done button if text length greater than zero
 */
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range
            withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

/*
 prepares for passing controller to Pick ICon view controller
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickIcon"])//
    {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

/*
 was icon picked?
 */
- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName
{
    _iconName = theIconName;//sets name of _iconName
    self.iconImageView.image = [UIImage imageNamed:_iconName];//sets image view
    [self.navigationController popViewControllerAnimated:YES];//pop up animation
}

@end
