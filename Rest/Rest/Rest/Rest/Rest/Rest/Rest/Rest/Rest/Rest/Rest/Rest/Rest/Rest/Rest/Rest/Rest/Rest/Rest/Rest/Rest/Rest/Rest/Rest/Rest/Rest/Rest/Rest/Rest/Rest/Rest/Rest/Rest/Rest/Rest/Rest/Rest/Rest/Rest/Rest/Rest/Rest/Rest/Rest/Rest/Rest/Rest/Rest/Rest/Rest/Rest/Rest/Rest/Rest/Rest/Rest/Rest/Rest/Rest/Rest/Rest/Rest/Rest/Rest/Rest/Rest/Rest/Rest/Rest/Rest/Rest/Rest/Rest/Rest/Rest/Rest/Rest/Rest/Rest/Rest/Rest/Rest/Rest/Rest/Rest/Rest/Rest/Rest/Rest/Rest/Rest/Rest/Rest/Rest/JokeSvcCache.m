//
//  JokeSvcCache.m
//  Rest
//
//  Created by Josh Gray on 5/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "JokeSvcCache.h"

@implementation JokeSvcCache

NSMutableArray *jokes = nil;

- (id) init {
    if (self = [super init]) {
        jokes = [NSMutableArray array];
        return self;
    }
    return nil;
}

- (Joke *) createJoke:(Joke *)joke {
    [jokes addObject: joke];
    return joke;
}


- (NSMutableArray *) retrieveAllJokes {
    return jokes;
}
/*
- (Contact *) updateContact:(Contact *) contact {
    return contact;
}

- (Contact *) deleteContact:(Contact *) contact {
    [contacts removeObject: contact]; //JKG
    return contact;
}
*/

@end
