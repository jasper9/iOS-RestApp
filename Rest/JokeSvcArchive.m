//
//  JokeSvcArchive.m
//  Rest
//
//  Created by Josh Gray on 6/6/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "JokeSvcArchive.h"

@implementation JokeSvcArchive

NSString *filePath;

NSMutableArray *jokes;

- (id) init {
    //NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsDir = [dirPaths objectAtIndex:0];
    filePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Jokes.archive"] ];
    NSLog(@"init: log path is %@", filePath);
    [self readArchive];
    return self;
}

- (void) readArchive {
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    
    if ([filemgr fileExistsAtPath: filePath])
    {
        jokes = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSLog(@"JokeSvcArchive.readArchive - file exists");
    }
    else
    {
        jokes = [NSMutableArray array];
        NSLog(@"JokeSvcArchive.readArchive - file does not exists");
    }
}

- (void) writeArchive {
    [NSKeyedArchiver archiveRootObject: jokes toFile:filePath];
    NSLog(@"JokeSvcArchive.writeArchive - wrote archive");
    
}


- (Joke *) createJoke: (Joke *) joke {
    NSLog(@"JokeSvcArchive.createJoke: %@", [joke description]);
    [jokes addObject: joke];
    //[self writeArchive];
    [NSKeyedArchiver archiveRootObject: jokes toFile:filePath];
    return joke;
}

/*
- (Joke *) createJoke:(Joke *)joke {
    [jokes addObject: joke];
    return joke;
}
*/

- (NSMutableArray *) retrieveAllJokes {
    
    return jokes;
}

/*
- (Joke *) updateJoke: (Joke *) joke {
    return joke;
}



- (Joke *) deleteJoke: (Joke *) joke {
    return joke;
}
*/

@end

