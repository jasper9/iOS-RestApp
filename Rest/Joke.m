//
//  Joke.m
//  Rest
//
//  Created by Josh Gray on 5/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "Joke.h"

@implementation Joke

- (NSString *) description {
    //return [NSString stringWithFormat: @"%@ %@" , _theId, _theJoke];
    return [NSString stringWithFormat: @"%@" , _theJoke];
}

@end
