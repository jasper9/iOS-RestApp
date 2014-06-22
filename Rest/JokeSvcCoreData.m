//
//  JokeSvcCoreData.m
//  JokeMgr2
//
//  Created by Josh Gray on 6/20/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import "JokeSvcCoreData.h"

@implementation JokeSvcCoreData

NSManagedObjectModel *model = nil;
NSPersistentStoreCoordinator *psc = nil;
NSManagedObjectContext *moc = nil;


- (id)  init {
    NSLog(@"init ENTERED");
    if(self = [super init]) {
        [self initializeCoreData];
        return self;
    }
    return nil;
}

- (Joke *) createJoke:(Joke *)joke {
    NSLog(@"createJoke ENTERED");
    
    //Joke *managedJoke = [self createManagedJoke];
    
    /*
     NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Joke" inManagedObjectContext:moc];
     [managedObject setValue:joke.name forKey:@"name"];
     [managedObject setValue:joke.phone forKey:@"phone"];
     [managedObject setValue:joke.email forKey:@"email"];
     */
    
   // managedJoke.id = joke.id;
   // managedJoke.theJoke = joke.theJoke;
    
    //managedJoke.email = joke.email;
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"createJoke ERROR: %@", [error localizedDescription]);
    }
    
    //return managedJoke;
    return joke;
}

- (void) saveJokes {
    NSLog(@"saveJokes ENTERED");
    
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"createJoke ERROR: %@", [error localizedDescription]);
    }
    
    //return managedJoke;
    //return joke;
}



- (NSArray *) retrieveAllJokes {
    NSLog(@"retrieveAllJokes ENTERED");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Joke" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    // removing sort
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    [self saveJokes];
    return fetchedObjects;
    
    /*
     NSMutableArray *jokes = [NSMutableArray arrayWithCapacity:fetchedObjects.count];
     for (NSManagedObject *managedObject in fetchedObjects) {
     Joke *joke = [[Joke alloc] init];
     joke.name = [managedObject valueForKey:@"name"];
     joke.phone = [managedObject valueForKey:@"phone"];
     joke.email = [managedObject valueForKey:@"email"];
     NSLog(@"joke: %@ ", [joke description]);
     [jokes addObject:joke];
     
     
     
     }
     return jokes;
     */
    
    
}

/*
- (Joke *) updateJoke:(Joke *)joke {
    NSLog(@"updateJoke ENTERED");
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"updateJoke ERROR: %@", [error localizedDescription]);
    }
    

    return joke;
}
*/

- (Joke *) deleteJoke:(Joke *)joke {
    NSLog(@"deleteJoke ENTERED");
    [moc deleteObject:joke];
    
    [self saveJokes];
    
    return joke;
}

- (void) initializeCoreData
{
    NSLog(@"initializeCoreData ENTERED");
    
    // initialize (load) the schema model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // initialize the persistent store coordinator with the model
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"JokesMgr.sqlite"];
    NSLog(@"initializeCoreData FILE %@", storeURL);
    NSError *error = nil;
    psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        //initialize the managed object context
        moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [moc setPersistentStoreCoordinator:psc];
        NSLog(@"initializeCoreData GOOD");
        
    } else {
        NSLog(@"initializeCoreData FAILED with error: %@", error);
        
    }
    
    
    
}

- (Joke *) createManagedJoke {
    NSLog(@"createManagedJoke ENTERED");
    
    //NSError *error = nil;
    
    Joke *joke = [NSEntityDescription insertNewObjectForEntityForName:@"Joke" inManagedObjectContext:moc];
    
    //NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //[request setEntity:[NSEntityDescription entityForName:@"Joke" inManagedObjectContext:moc]];
    
    //[request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)

   // NSUInteger count = [moc countForFetchRequest:moc error:&error];
   // NSLog(@"createManagedJoke ROW COUNT NOW %lu", (unsigned long)count);
    return joke;
    
}


@end
