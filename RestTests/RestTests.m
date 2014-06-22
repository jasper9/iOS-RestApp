//
//  RestTests.m
//  RestTests
//
//  Created by Josh Gray on 5/21/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Joke.h"
//#import "JokeSvcArchive.h"

@interface RestTests : XCTestCase

@end

@implementation RestTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJokeSvcArchive
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
    /*
    NSLog(@"*** Starting testJokeSvcArchive ***");
    JokeSvcArchive *jokeSvc = [[JokeSvcArchive alloc] init];
    NSUInteger initialCount = [[jokeSvc retrieveAllJokes] count];
    
    Joke *joke = [[Joke alloc] init];
    joke.theJoke = @"This is my test joke 1.";
    joke.theId = @"42";
    
    [jokeSvc createJoke:(Joke *) joke];
    NSUInteger finalCount = [[jokeSvc retrieveAllJokes] count];
    
    XCTAssertEqual((NSUInteger)initialCount + 1, (NSUInteger)finalCount, @"initial count %lu, final count %lu ", initialCount, (unsigned long)finalCount);
    */
    
//  #### HERE START NSLOGS
    //NSLog(@"*** The Count: %i", count);
    //NSLog(@"*** Ending testJokeSvcArchive ***");
    
    
}

@end
