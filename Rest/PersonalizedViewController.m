//
//  PersonalizedViewController.m
//  Rest
//
//  Created by Josh Gray on 6/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "PersonalizedViewController.h"
#import "Joke.h"
//#import "JokeSvcCache.h"
#import "JokeSvcCoreData.h" // added june 21 2014
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface PersonalizedViewController ()

@end

@implementation PersonalizedViewController

@synthesize nameFirst;
@synthesize nameLast;

JokeSvcCoreData *jokeSvc2 = nil;

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
    NSLog(@"PersonalizedViewController : viewDidLoad : ENTERED");
    [super viewDidLoad];
    

    CGRect labelFrame = CGRectMake(20, 200, 280, 150);
    UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    //[myLabel setBackgroundColor:[UIColor orangeColor]];
    
    // // NSString *labelText = jokeID;
    //NSString *labelText = @"this is a test";
    // NSString *labelText = jokeID; <----------------------------------
    
    // testing
    jokeSvc2 = [[JokeSvcCoreData alloc] init];
    
    
    // ==================================================
    // format: http://api.icndb.com/jokes/random?firstName=John&amp;lastName=Doe
    NSString *myURL = @"http://api.icndb.com/jokes/random?firstName=";
    
    //NSString *myURL_full = [myURL stringByAppendingString:nameFirst];
    myURL = [myURL stringByAppendingString:nameFirst];
    myURL = [myURL stringByAppendingString:@"&lastName="];
    myURL = [myURL stringByAppendingString:nameLast];
    
    NSLog(@"PersonalizedViewController : URL : %@", myURL);

    
    NSURL *url = [NSURL URLWithString:myURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             id greeting = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:NULL];
             
             
             NSError *error = nil;
             

             
             
             
             NSLog(@"Greeting: %@", greeting);
             id values = [greeting valueForKey:@"value"];
             NSLog(@"Values: %@", values);
             id theId = [values valueForKey:@"id"];
             NSLog(@"ID: %@", theId);
             NSString *theJoke = [values valueForKey:@"joke"];
             NSLog(@"JOKE: %@", theJoke);
             
             NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"&quot;" options:NSRegularExpressionCaseInsensitive error:&error];
             NSString *modifiedString = [regex stringByReplacingMatchesInString:theJoke options:0 range:NSMakeRange(0, [theJoke length]) withTemplate:@"\""];
             theJoke = modifiedString;
             
             NSString *labelText;
             if (theJoke.length > 0)
             {
                 labelText = theJoke;
                 
             }
             else
             {
                 labelText = @"Sorry, that joke was not found.";
             }
             [myLabel setText:labelText];
             [myLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0]];
             [myLabel setNumberOfLines:0];
             [myLabel sizeToFit];
             [self.view addSubview:myLabel];
             
             //self.greetingId.text = [NSString stringWithFormat:@"%@", theId];
             //self.greetingContent.text = theJoke;
             
             Joke *joke = [jokeSvc2 createManagedJoke];
             
             NSDate *now = [[NSDate alloc] init];
             NSLog(@"NOW: %@", now);
             
             joke.theJoke = theJoke;
             joke.id = theId;
             joke.datetime = now;
             
             //joke.theJoke = theJoke;
             //joke.id = theId;
             //joke.datetime = now;
             
             
             //[self.tableView reloadData];
             
             
             
             //self.greetingId.text = [values valueForKey:@"id"];
             //id forecastday = [simpleforecast valueForKey:@"forecastday"];
             //self.greetingId.text = [[theJoke objectForKey:@"id"] stringValue];
             //self.greetingContent.text = [theJoke objectForKey:@"joke"];
             
             
             
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue: ENTERED");
    
        
    
    // THIS ONE NEEDS WORK TO MASSAGE THE VARIABLES
    if ([segue.identifier isEqualToString:@"SavePersonalized"]) {
        NSLog(@"prepareForSegue: ENTERED SavePersonalized");
        NSLog(@"id : %@",self.CaptureInformation_first.text);
        NSLog(@"text : %@",self.CaptureInformation_last.text);
        PersonalizedViewController *destViewController = segue.destinationViewController;
        destViewController.nameFirst = self.CaptureInformation_first.text;
        destViewController.nameLast = self.CaptureInformation_last.text;
    }
    //
}

@end