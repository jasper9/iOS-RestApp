//
//  JokeSvc.h
//  Rest
//
//  Created by Josh Gray on 5/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Joke.h"
@protocol JokeSvc <NSObject>

- (Joke *) createJoke: (Joke *) joke;
- (NSMutableArray *) retrieveAllJokes;
//- (Contact *) updateContact: (Contact *) contact;
- (Joke *) deleteJoke: (Joke *) joke;
@end
