//
//  TMMessage.h
//  Tagged Messaging
//
//  Created by Ranit Dubey on 8/19/14.
//  Copyright (c) 2014 Tagged. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMMessage : NSObject
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSString *receiver;


@end
