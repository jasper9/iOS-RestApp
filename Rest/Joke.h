//
//  Joke.h
//  Rest
//
//  Created by Josh Gray on 5/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Joke : NSObject <NSCoding>

// hmmm
//@property (nonatomic, strong) NSString *theId;
@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *theJoke;

@end
