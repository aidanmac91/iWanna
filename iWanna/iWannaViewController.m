//
//  iWannaViewController.m
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "iWannaViewController.h"

@interface iWannaViewController ()

@end

@implementation iWannaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.list.name;//sets titles to the item
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];//sets background colour
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//sets color of settings/+ to white
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];//sets colour of title to white
    self.navigationController.navigationBar.translucent = NO;//not transparent
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;//makes status bar white so it can be seen.
    

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 number of rows in selection
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list.items count];
}

/*
 asks data source for cell when displaying particular row
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iWannaItem"];//gets cell for next item
    iWannaItem *item = self.list.items[indexPath.row];//gets next item
    [self configureTextForCell:cell withChecklistItem:item];//passes cell and item to be configured

    
    //TODO remove configure
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}


/*
 handles toggling
 //TODO needs to be removed
 */
- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(iWannaItem *)item
{
    UILabel *label2=(UILabel *)[cell viewWithTag:1000];//label of cell
    if (item.checked) {//is pressed
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:label2.text];//inits attributeString with text of label
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];//adds strikethrough to text
        label2.attributedText=attributeString;//sets label to attributeString
        label2.textColor=[UIColor grayColor];//greys out text
        
    }
    else//if unchecked
    {
        label2.text=label2.text;//resets text to non strikethrough version
        if([item.priority isEqualToString:@"2"])//if high
        {
             label2.textColor=[UIColor redColor];//sets colour to red
        }
        else//otherwise sets default color;
        {
            label2.textColor= cell.textLabel.textColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];
            
        }
        
    }
}

/*
 called if cell is pressed
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];//gets cell
    iWannaItem *item = self.list.items[indexPath.row];//gets item for cell
    [item toggleChecked];//toggles checked
    
    //TODO remove
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//animiated deselection
}

/*
 sets the text of the label
 */
- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(iWannaItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];//gets label
    label.text = item.text;
    if([item.priority isEqualToString:@"2"])
    {
        label.textColor=[UIColor redColor];
    }
    else
    {
        label.textColor= cell.textLabel.textColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];
    }
}

/*
 allows swipe to delete
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.list.items removeObjectAtIndex:indexPath.row];//removes item
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths
                     withRowAnimation:UITableViewRowAnimationAutomatic];//animation
}

/*
 stops aminationn
 */
- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 adds new item
 */
- (void)itemDetailViewController:(ItemDetailViewController *)controller
          didFinishAddingItem:(iWannaItem *)item
{
    NSInteger newRowIndex = [self.list.items count];//gets new row
    [self.list.items addObject:item];//adds item
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];//array of indexPath
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];//animation for adding
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 prepares for transition to new view
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItem"])//via AddItem segue
    {
        UINavigationController *navigationController = segue.destinationViewController;//gets destination
        ItemDetailViewController *controller = (ItemDetailViewController *)
        navigationController.topViewController;//gives control to new controller
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"EditItem"])//via EditItem
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)
        navigationController.topViewController; controller.delegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = self.list.items[indexPath.row];//passes item to controller
    }
}

/*
 editing information
 */
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(iWannaItem *)item
{
    NSInteger index = [self.list.items indexOfObject:item];//gets index of item
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index
                                                inSection:0];//gets path of index
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];//creates cell at path
    [self configureTextForCell:cell withChecklistItem:item];//config cell
    [self dismissViewControllerAnimated:YES completion:nil];//animation
}


@end
