//
//  Joke.m
//  Rest
//
//  Created by Josh Gray on 5/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "Joke.h"

//static  int *const ID = 0;
static NSString *const THEJOKE = @"thejoke";
static NSString *const THEID = @"theid";

@implementation Joke

- (NSString *) description {
    //return [NSString stringWithFormat: @"%@ %@" , _theId, _theJoke];
    return [NSString stringWithFormat: @"%@" , _theJoke];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    //[coder encodeObject:self.theId forKey:THEID];
    //[coder encodeObject:self.id forKey:THEID];
    [coder encodeObject:self.theJoke forKey:THEJOKE];

}


- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
     //   _theId = [coder decodeObjectForKey:THEID];
        _theJoke = [coder decodeObjectForKey:THEJOKE];
    }
    return self;
}

@end
