//
//  TMInboxTableViewController.m
//  Tagged Messaging
//
//  Created by Ranit Dubey on 8/15/14.
//  Copyright (c) 2014 Tagged. All rights reserved.
//

#import "TMInboxTableViewController.h"
#import "InboxTableViewCell.h"
#import "TMChatViewController.h"

@interface TMInboxTableViewController ()
@property (nonatomic, strong) NSArray *availableUsers;
@property (nonatomic, strong) NSArray *loggedOutUsers;


@end

@implementation TMInboxTableViewController

@synthesize availableUsers = _availableUsers;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self) {
        self.availableUsers= @[@"Brett", @"Umang", @"Nik", @"Ranit", @"Aaron"];
        self.loggedOutUsers= @[@"Erik", @"John", @"Misha", @"Mike",@"Jayesh"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InboxTableViewCell *cell = (InboxTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"inbox_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.indexLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    if (indexPath.section == 0) {
        cell.indexLabel.text = [self.availableUsers objectAtIndex:(NSUInteger)indexPath.row];
    } else {
        cell.indexLabel.text = [self.loggedOutUsers objectAtIndex:(NSUInteger)indexPath.row];
    }

    
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)s
{
    if (s == 0) {
        return @"Available";
    } else {
        return @"Logged Out";
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"inbox_to_chat"]) {
        InboxTableViewCell *cell = (InboxTableViewCell *)sender;
        TMChatViewController *chatViewController = segue.destinationViewController;
        chatViewController.otherPerson = cell.indexLabel.text;
        chatViewController.me = @"Ranit";
    }
}


@end
