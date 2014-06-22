//
//  Joke.h
//  Rest
//
//  Created by Josh Gray on 6/21/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Joke : NSManagedObject

@property (nonatomic, retain) NSString * theJoke;
@property (nonatomic, retain) NSNumber * id;

@end
