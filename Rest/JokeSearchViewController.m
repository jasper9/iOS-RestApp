//
//  JokeSearchViewController.m
//  Rest
//
//  Created by Josh Gray on 6/6/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "JokeSearchViewController.h"
#import "Joke.h"
#import "JokeSvcCache.h"

@interface JokeSearchViewController ()

@end

@implementation JokeSearchViewController

//@synthesize jokeLabel;
@synthesize jokeID;

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
    NSLog(@"JokeSearchViewController : viewDidLoad : ENTERED");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CGRect labelFrame = CGRectMake(20, 300, 280, 150);
    UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    //[myLabel setBackgroundColor:[UIColor orangeColor]];
    
    // // NSString *labelText = jokeID;
    //NSString *labelText = @"this is a test";
    NSString *labelText = jokeID;
    
    
    
    
    
    // ==================================================
    // this is where i'm working
    
    NSURL *url = [NSURL URLWithString:@"http://api.icndb.com/jokes/random"];
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
             
             NSLog(@"Greeting: %@", greeting);
             id values = [greeting valueForKey:@"value"];
             NSLog(@"Values: %@", values);
             id theId = [values valueForKey:@"id"];
             NSLog(@"ID: %@", theId);
             NSString *theJoke = [values valueForKey:@"joke"];
             NSLog(@"JOKE: %@", theJoke);
             
             self.greetingId.text = [NSString stringWithFormat:@"%@", theId];
             self.greetingContent.text = theJoke;
             
             Joke *joke = [jokeSvc createManagedJoke];
             
             NSDate *now = [[NSDate alloc] init];
             NSLog(@"NOW: %@", now);
             
             joke.theJoke = theJoke;
             joke.id = theId;
             joke.datetime = now;
             
             
             [self.tableView reloadData];
             
             
             
             //self.greetingId.text = [values valueForKey:@"id"];
             //id forecastday = [simpleforecast valueForKey:@"forecastday"];
             //self.greetingId.text = [[theJoke objectForKey:@"id"] stringValue];
             //self.greetingContent.text = [theJoke objectForKey:@"joke"];
             
             
             
         }
     }];
 
    
    
    
    
    
    
    
    
     // ==================================================
    
    [myLabel setText:labelText];
    [myLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0]];
    // Tell the label to use an unlimited number of lines
    [myLabel setNumberOfLines:0];
    [myLabel sizeToFit];
    
    [self.view addSubview:myLabel];
    
    
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
