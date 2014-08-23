//
//  TMReceiverChatTableViewCell.h
//  Tagged Messaging
//
//  Created by Ranit Dubey on 8/20/14.
//  Copyright (c) 2014 Tagged. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMReceiverChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topVerticalMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVerticalMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;

@end
