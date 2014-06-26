//
//  RapidViewController.m
//  Rest
//
//  Created by Josh Gray on 6/25/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "RapidViewController.h"
#import "Joke.h"
#import "JokeSvcCoreData.h" // added june 21 2014

@interface RapidViewController ()

@end

@implementation RapidViewController

@synthesize Count;
JokeSvcCoreData *jokeSvc4 = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"RapidViewController : viewDidLoad : ENTERED");
    [super viewDidLoad];
    
    

    jokeSvc4 = [[JokeSvcCoreData alloc] init];
    
    
    // ==================================================
    // format: http://api.icndb.com/jokes/random?firstName=John&amp;lastName=Doe
    NSString *myURL = @"http://api.icndb.com/jokes/random/";
    
    NSLog(@"RapidViewController : COUNT : %@", Count);
    
    
    //NSString *myURL_full = [myURL stringByAppendingString:nameFirst];
    myURL = [myURL stringByAppendingString:Count];
    //myURL = [myURL stringByAppendingString:@"&lastName="];
    //myURL = [myURL stringByAppendingString:nameLast];
    
    NSLog(@"RapidViewController : URL : %@", myURL);
    
    
    NSURL *url = [NSURL URLWithString:myURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         
         //int loopCounter = 0;
         
         if (data.length > 0 && connectionError == nil)
         {
             
             
             
             id greeting = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:NULL];
             
             
             //NSError *error = nil;
             
             
             
             
             
             NSLog(@"Greeting: %@", greeting);
             id values = [greeting valueForKey:@"value"];
             NSLog(@"Values: %@", values);
             id theId = [values valueForKey:@"id"];
             NSLog(@"ID: %@", theId);
             //NSString *theJoke = [values valueForKey:@"joke"];
             NSString *theJoke = [values valueForKey:@"joke"]; //2
             NSLog(@"JOKE: %@", theJoke);
             
        

             int myCounter = 0;
             //for (int myCounter=0; myCounter<=(int)Count; myCounter++) {
             for (id eachJoke in values) {
                 //NSString *eachJoke = [theJoke objectAtIndex:myCounter];
                 //id eachJoke = [values indexOfObject:myCounter];
                 NSString* thisJoke = [eachJoke valueForKey:@"joke"]; //2
                 NSString* thisID = [eachJoke valueForKey:@"id"]; //2
                 
                 NSLog(@"Loop %d: [%@] %@", myCounter, thisID, thisJoke);
            
                 
                 int startingLoc = 100 + (myCounter*75);
                 
                 CGRect labelFrame = CGRectMake(20, startingLoc, 280, 150);
                 
                 UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
                 
                 
                 
                 /*
                  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"&quot;" options:NSRegularExpressionCaseInsensitive error:&error];
                 NSString *modifiedString = [regex stringByReplacingMatchesInString:theJoke options:0 range:NSMakeRange(0, [theJoke length]) withTemplate:@"\""];
                 theJoke = modifiedString;
                 */
                 
                 NSString *labelText;
                 //if (theJoke.length > 0)
                 //{
                     labelText = thisJoke;
                     
                 //}
                 //else
                 //{
                 //    labelText = @"Sorry, that joke was not found.";
                 //}
                 [myLabel setText:labelText];
                 [myLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
                 [myLabel setNumberOfLines:0];
                 [myLabel sizeToFit];
                 [self.view addSubview:myLabel];
                 

                 
                 Joke *joke = [jokeSvc4 createManagedJoke];
                 
                 NSDate *now = [[NSDate alloc] init];
                 NSLog(@"NOW: %@", now);
                 
                 joke.theJoke = thisJoke;
                 joke.id = thisID;
                 joke.datetime = now;
                 
                 myCounter++;
             
             }

             
             
             
         }
     }];
    
    
    
    
    
    
    
    
    
    // ==================================================
    
    
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
