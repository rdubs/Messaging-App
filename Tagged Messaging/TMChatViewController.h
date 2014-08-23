//
//  TMChatViewController.h
//  Tagged Messaging
//
//  Created by Ranit Dubey on 8/19/14.
//  Copyright (c) 2014 Tagged. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSString *otherPerson;
@property (strong, nonatomic) NSString *me;
@property (weak, nonatomic) IBOutlet UITableView *messagesTable;

@end
