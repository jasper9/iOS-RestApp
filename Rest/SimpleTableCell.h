//
//  SimpleTableCell.h
//  Rest
//
//  Created by Josh Gray on 5/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleTableCell : NSObject

@property (nonatomic, weak) IBOutlet UILabel *jokeLabel;
@property (nonatomic, weak) IBOutlet UILabel *idLabel;

@end
