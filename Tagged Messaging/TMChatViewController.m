//
//  TMChatViewController.m
//  Tagged Messaging
//
//  Created by Ranit Dubey on 8/19/14.
//  Copyright (c) 2014 Tagged. All rights reserved.
//

#import "TMChatViewController.h"
#import "TMMessage.h"
#include <stdlib.h>
#include "TMSenderChatTableViewCell.h"
#include "TMReceiverChatTableViewCell.h"


@interface TMChatViewController ()
@property (strong, nonatomic) NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
@property (weak, nonatomic) IBOutlet UIView *textInputContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textInputContainerViewVerticalSpace;
@property (strong, nonatomic) UITapGestureRecognizer *closeKeyboardTapRecognizer;
@property (strong, nonatomic) NSMutableArray *cellHeightCache;



@end

@implementation TMChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.messages = [[NSMutableArray alloc] init];
    NSArray *messageText = @[
                             @"Fashion axe keffiyeh Cosby sweater, slow-carb flannel Williamsburg photo booth. Bitters Echo Park photo booth lo-fi paleo dreamcatcher pour-over roof party flannel aesthetic. Letterpress whatever Shoreditch, sriracha plaid art party 8-bit photo booth.",
                             @"Deep v asymmetrical lo-fi, Schlitz pug pickled Portland Carles Tonx. Shoreditch kogi sriracha, food truck Thundercats bespoke meh gluten-free semiotics fap scenester selvage polaroid. Fixie literally cardigan pickled, fap crucifix scenester hoodie authentic selfies bitters McSweeney's lo-fi narwhal.",
                             @"Tofu Brooklyn meh bicycle rights wayfarers, Williamsburg chillwave ethical hella.",
                             @"Seitan sriracha twee tattooed, shabby chic Truffaut Austin Schlitz letterpress locavore authentic. Stumptown keffiyeh authentic, raw denim organic normcore High Life swag selfies vinyl American Apparel narwhal literally master cleanse.",
                             @"Mlkshk stumptown Echo Park kitsch 8-bit. Kogi small batch beard High Life disrupt whatever. PBR tousled keytar, mixtape flannel Shoreditch bitters stumptown twee Pitchfork meh iPhone XOXO."
                             ];
    for (int i = 0; i < 10; i++) {
        TMMessage *message = [[TMMessage alloc] init];
        message.text = messageText[arc4random() % 4];
        int sender = arc4random() % 2;
        if (sender == 0) {
            message.sender = @"Ranit";
            message.receiver = self.otherPerson;
        } else {
            message.sender = self.otherPerson;
            message.receiver = @"Ranit";
        }
        [self.messages addObject:message];
        [self cacheCellHeightForText:message.text forRow:self.messages.count - 1];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
    
}

- (NSMutableArray *)cellHeightCache {
    if (_cellHeightCache == nil) {
        _cellHeightCache = [NSMutableArray array];
    }
    return _cellHeightCache;
}

#pragma mark - UITableView Data Source Protocol

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isCellAtIndexPathSenderCell:indexPath]) return [self tableView:tableView senderCellForRowAtIndexPath:indexPath];
    return [self tableView:tableView receiverCellForRowAtIndexPath:indexPath];
}

- (BOOL)isCellAtIndexPathSenderCell:(NSIndexPath *)indexPath {
    TMMessage *message = [self.messages objectAtIndex:indexPath.row];
    return [message.sender isEqualToString:self.me];
}

- (TMReceiverChatTableViewCell *)tableView:(UITableView *)tableView receiverCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMReceiverChatTableViewCell *cell = (TMReceiverChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"receiver_cell" forIndexPath:indexPath];
    cell.indexLabel.text = ((TMMessage *)[self.messages objectAtIndex:indexPath.row]).text;
    return cell;
}

- (TMSenderChatTableViewCell *)tableView:(UITableView *)tableView senderCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMSenderChatTableViewCell *cell = (TMSenderChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"sender_cell" forIndexPath:indexPath];
    cell.indexLabel.text = ((TMMessage *)[self.messages objectAtIndex:indexPath.row]).text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *number = self.cellHeightCache[indexPath.row];
    return [number floatValue];
}

- (void)cacheCellHeightForText:(NSString *)text forRow:(NSInteger)row {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    CGFloat topMargin = 10.0;
    CGFloat bottomMargin = 10.0;
    CGFloat width = 160.0;
    /*
    if ([self isCellAtIndexPathSenderCell:indexPath]) {
        TMSenderChatTableViewCell *cell = (TMSenderChatTableViewCell *)[self.messagesTable dequeueReusableCellWithIdentifier:@"sender_cell" forIndexPath:nil];
        topMargin = cell.topVerticalMargin.constant;
        bottomMargin = cell.bottomVerticalMargin.constant;
        width = cell.labelWidth.constant;
    } else {
        TMReceiverChatTableViewCell *cell = (TMReceiverChatTableViewCell *)[self.messagesTable dequeueReusableCellWithIdentifier:@"receiver_cell" forIndexPath:nil];
        topMargin = cell.topVerticalMargin.constant;
        bottomMargin = cell.bottomVerticalMargin.constant;
        width = cell.labelWidth.constant;
    }
     */
    CGSize boundingSize = CGSizeMake(width, MAXFLOAT);
    CGRect textSize = [text boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0]} context:nil];
    CGFloat textHeight = textSize.size.height + 5.0;
    [self.cellHeightCache insertObject:@(textHeight + topMargin + bottomMargin) atIndex:indexPath.row];
}

#pragma mark - Actions
- (void)handleTapToCloseKeyboard:(id)sender {
    [self.messageField endEditing:YES];
//    [self.view endEditing:YES];
    
}
- (IBAction)sendMessage {

    NSString *messageStr = self.messageField.text;
    if([messageStr length] > 0) {
        
        TMMessage *m = [[TMMessage alloc] init];
        m.sender = self.me;
        m.receiver = self.otherPerson;
        m.text = messageStr;
        [self cacheCellHeightForText:m.text forRow:self.messages.count];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count inSection:0];
        [self.messages addObject:m];
        
        [self.messagesTable beginUpdates];
        [self.messagesTable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.messagesTable endUpdates];
        [self.messagesTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        self.messageField.text = @"";
        [self.view endEditing:YES];
        
    }
}

#pragma mark - Keyboard Notification

- (void)keyboardWillAppear:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [keyboardFrameValue CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    NSNumber *keyboardFrameAnimationTimeValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval keyboardAnimationTime = [keyboardFrameAnimationTimeValue doubleValue];
    self.closeKeyboardTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapToCloseKeyboard:)];
    [self.messagesTable addGestureRecognizer:self.closeKeyboardTapRecognizer];
    [UIView animateWithDuration:keyboardAnimationTime animations:^{
        self.textInputContainerViewVerticalSpace.constant = keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    [self.messagesTable removeGestureRecognizer:self.closeKeyboardTapRecognizer];
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *keyboardFrameAnimationTimeValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval keyboardAnimationTime = [keyboardFrameAnimationTimeValue doubleValue];
    [UIView animateWithDuration:keyboardAnimationTime animations:^{
        self.textInputContainerViewVerticalSpace.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

@end
