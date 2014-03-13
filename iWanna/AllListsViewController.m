//
//  AllListsViewController.m
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "AllListsViewController.h"
#import "iWannaViewController.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];//sets background colour
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//sets color of settings/+ to white
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];//sets colour of title to white
    self.navigationController.navigationBar.translucent = NO;//set traslucent to false
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;//status bar to white
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 called if cell is pressed
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel setIndexOfSelectediWannalist:indexPath.row];//sets dataModel to index
    iWannaList *iWannaList = self.dataModel.lists[indexPath.row];//sets iWannaList to dataModel
    [self performSegueWithIdentifier:@"ShowChecklist" sender:iWannaList];//calls segue for list of items
}

/*
 gets number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.lists count];
}

/*
 asks data source for cell when displaying particular row
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];//gets cell
    if (cell == nil)//no cell
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"List %ld", (long)indexPath.row];
    
    iWannaList *iwannaList = self.dataModel.lists[indexPath.row];//sets iWannaList to dataModel
    cell.textLabel.text = iwannaList.name;//sets text to iwannaList's name
    cell.textLabel.textColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];//sets color of text
    
    cell.accessoryType =UITableViewCellAccessoryDetailDisclosureButton;//adds info and > to cell
    int count = [iwannaList countUncheckedItems];//check how many items are unchecked
    if ([iwannaList.items count] == 0)
    {
        cell.detailTextLabel.text = @"(No Items)";
    }
    else if (count == 0)
    {
        cell.detailTextLabel.text = @"All Done!";
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining", count];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:1.0f/255.0f green:46.0f/255.f blue:72.0f/255.0f alpha:1];//sets color
    cell.imageView.image = [UIImage imageNamed:iwannaList.iconName];
    return cell;
}

/*
 prepares for transition to new view
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowChecklist"])//show item
    {
        iWannaViewController *controller = segue.destinationViewController;
        controller.list = sender;
    }
    else if ([segue.identifier isEqualToString:@"AddChecklist"])//adds item
    {
        UINavigationController *navigationController =segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)
        navigationController.topViewController;
        controller.delegate = self;
        controller.iwannalistToEdit = nil;//no item to edit
    }
}


/*
 animation when cancel
 */
- (void)listDetailViewControllerDidCancel: (ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
 finished adding checklists
 */
- (void)listDetailViewController:(ListDetailViewController *)controller
        didFinishAddingChecklist:(iWannaList *)iwannaList
{
    [self.dataModel.lists addObject:iwannaList];//adds list
    [self.dataModel sortiWannaLists];//sorts alphabetically
    [self.tableView reloadData];//updates
    [self dismissViewControllerAnimated:YES completion:nil];//animation
}

/*
 finished editing checklist
 */
- (void)listDetailViewController:(ListDetailViewController *)controller
       didFinishEditingChecklist:(iWannaList *)iwannaList
{
    [self.dataModel sortiWannaLists];//sorts alphabetically
    [self.tableView reloadData];//updates
    [self dismissViewControllerAnimated:YES completion:nil];//animation
}

/*
 remove list
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
 when the user presses the info button
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:
(NSIndexPath *)indexPath
{
    UINavigationController *navigationController =
    [self.storyboard instantiateViewControllerWithIdentifier: @"ListNavigationController"];//finds controller
    ListDetailViewController *controller = (ListDetailViewController *)
    navigationController.topViewController;
    controller.delegate = self;
    iWannaList *iwannaList = self.dataModel.lists[indexPath.row];//gets list
    controller.iwannalistToEdit = iwannaList;//passes list
    [self presentViewController:navigationController animated:YES completion:nil];
}

/*
 If the back button was pressed, then the new view controller is AllListsViewController itself and you set the “ChecklistIndex” value in NSUserDefaults to -1, meaning that no checklist is currently selected.
 */
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectediWannalist:-1];
    }
}

/*
 successful view appear
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    NSInteger index = [self.dataModel indexOfSelectedChecklist];
    if (index >= 0 && index < [self.dataModel.lists count])
    {
        iWannaItem *iwannaList = self.dataModel.lists[index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:iwannaList];//
    }
}

/*
 view will appear
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}




@end
