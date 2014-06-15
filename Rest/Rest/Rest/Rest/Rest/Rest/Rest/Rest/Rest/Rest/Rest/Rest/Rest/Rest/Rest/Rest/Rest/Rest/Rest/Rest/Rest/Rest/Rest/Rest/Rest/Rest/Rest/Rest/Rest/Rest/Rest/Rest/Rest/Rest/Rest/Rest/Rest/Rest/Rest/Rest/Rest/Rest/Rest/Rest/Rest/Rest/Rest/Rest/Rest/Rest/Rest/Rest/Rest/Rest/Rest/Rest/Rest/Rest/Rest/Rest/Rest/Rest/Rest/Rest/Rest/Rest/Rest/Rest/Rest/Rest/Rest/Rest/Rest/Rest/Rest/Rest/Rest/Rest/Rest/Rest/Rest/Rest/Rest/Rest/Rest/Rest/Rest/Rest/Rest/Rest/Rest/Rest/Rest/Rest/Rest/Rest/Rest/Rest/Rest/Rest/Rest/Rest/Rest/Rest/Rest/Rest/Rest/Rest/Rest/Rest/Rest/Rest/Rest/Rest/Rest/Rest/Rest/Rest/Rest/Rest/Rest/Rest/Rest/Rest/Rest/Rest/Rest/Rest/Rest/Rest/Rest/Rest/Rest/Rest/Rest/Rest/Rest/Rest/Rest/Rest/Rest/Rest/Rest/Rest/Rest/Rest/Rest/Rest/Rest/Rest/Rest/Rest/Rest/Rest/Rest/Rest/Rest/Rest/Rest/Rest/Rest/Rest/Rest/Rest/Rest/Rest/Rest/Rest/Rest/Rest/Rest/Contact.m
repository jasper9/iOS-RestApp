//
//  Contact.m
//  Rest
//
//  Created by Josh Gray on 5/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (NSString *) description {
    return [NSString stringWithFormat: @"%@ %@" , _theId, _theJoke];
}

@end
