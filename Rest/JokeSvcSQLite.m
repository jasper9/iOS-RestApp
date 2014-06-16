//
//  JokeSvcSQLite.m
//  Rest
//
//  Created by Josh Gray on 6/15/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "JokeSvcSQLite.h"
#import <sqlite3.h>

@implementation JokeSvcSQLite
NSString *databasePath = nil;
sqlite3 *database = nil;

- (id)init {
    if ((self = [super init])) {
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:@"joke.sqlite3"];
        
        if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
            NSLog(@"database is open");
            NSLog(@"database file path: %@", databasePath);
            
            NSString *createSQL = @"create table if not exists joke (id integer primary key autoincrement, theJoke varchar(255))";
            
            char *errMsg;
            if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table %s", errMsg);
            }
            
            
        } else {
            NSLog(@"*** Failed to open database!");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
            
            
        }
        
    }
    return self;
    
}

- (Joke *) createJoke: (Joke *)joke {
    sqlite3_stmt *statement;
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO joke (theJoke) VALUES (\"%@\")", joke.theJoke];
    if (sqlite3_prepare_v2(database, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            //joke.id = sqlite3_last_insert_rowid(database);
            long long myID = sqlite3_last_insert_rowid(database);
            //joke.id = (int)myID;
            joke.id = @(myID).intValue;
            
            
            NSLog(@"*** joke added");
        } else {
            NSLog(@"*** joke NOT ADDED");
            NSLog(@"*** SQL error %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
        
        
    }
    
    
    return joke;
}

- (NSMutableArray *) retrieveAllJokes {
    NSMutableArray *jokes = [NSMutableArray array];
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM joke ORDER BY id"];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        NSLog(@"*** jokes retrieved");
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            char *theJokeChars = (char *)sqlite3_column_text(statement, 1);
            //char *phoneChars = (char *)sqlite3_column_text(statement, 2);
            //char *emailChars = (char *)sqlite3_column_text(statement, 3);
            
            Joke *joke = [[Joke alloc] init];
            joke.id = id;
            joke.theJoke = [[NSString alloc] initWithUTF8String:theJokeChars];
            //joke.phone = [[NSString alloc] initWithUTF8String:phoneChars];
            //joke.email = [[NSString alloc] initWithUTF8String:emailChars];
            [jokes addObject:joke];
            
            
            
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"*** jokes NOT retrieved");
        NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
    }
    return jokes;
}

/*
- (Joke *) updatejoke:(Joke *)joke {
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE joke SET name=\"%@\", phone=\"%@\", email=\"%@\" WHERE id = %i ", joke.name, joke.phone, joke.email, joke.id];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [updateSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"*** joke updated");
        } else {
            NSLog(@"*** joke NOT updated");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
            
        }
        sqlite3_finalize(statement);
    }
    
    
    return joke;
}
*/


- (Joke *) deleteJoke:(Joke *)joke {
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM joke WHERE id = %i ", joke.id];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"*** joke deleted");
            
        } else {
            NSLog(@"*** joke NOT deleted");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
            
        }
        sqlite3_finalize(statement);
        
    }
    return joke;
}

- (void)dealloc {
    sqlite3_close(database);
}
@end

