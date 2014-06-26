//
//  RestViewController.m
//  Rest
//
//  Created by Josh Gray on 5/21/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "RestViewController.h"
#import "Joke.h"
//#import "JokeSvcCache.h"
//#import "JokeSvcArchive.h" // added june 6 2014
//#import "JokeSvcSQLite.h" // added june 15 2014
#import "JokeSvcCoreData.h" // added june 21 2014


#import "JokeDetailViewController.h"
#import "JokeSearchViewController.h"
#import "PersonalizedViewController.h"
#import "RapidViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"


@interface RestViewController ()

@end

@implementation RestViewController

@synthesize CaptureInformation;
@synthesize SendInformation;

@synthesize CaptureInformation_first;
@synthesize CaptureInformation_last;
@synthesize Count;
//JokeSvcCache *jokeSvc = nil;
//JokeSvcArchive *jokeSvc = nil;
//JokeSvcSQLite *jokeSvc = nil;
JokeSvcCoreData *jokeSvc = nil;



- (IBAction)fetchGreeting;
{
    NSLog(@"fetchGreeting: ENTERED");
    
    // http://api.icndb.com/jokes/random
    // http://rest-service.guides.spring.io/greeting
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
             // id theId = [values valueForKey:@"id"];   //JKG HOW IT IS BEFORE SQL
             id theId = [values valueForKey:@"id"];
             //NSString *theId = [[values objectAtIndex: 0]objectForKey:@"id"];
             NSLog(@"ID: %@", theId);
             NSString *theJoke = [values valueForKey:@"joke"];
             NSLog(@"JOKE: %@", theJoke);
             //self.greetingId.text = [values valueForKey:@"id"];
             
             self.greetingId.text = [NSString stringWithFormat:@"%@", theId];
             self.greetingContent.text = theJoke;
        
             //Joke *joke = [[Joke alloc] init];
             Joke *joke = [jokeSvc createManagedJoke];
             //Joke *joke = [jokeSvc createJoke];
             
             // new stuff
             //NSDate *date = [NSDate date];
             //long *epoc = [@(floor([date timeIntervalSince1970])) longLongValue];
             NSDate *now = [[NSDate alloc] init];
             NSLog(@"NOW: %@", now);
             
             joke.theJoke = theJoke;
             //joke.theId = [NSString stringWithFormat:@"%@", theId];
             //joke.id = [NSString stringWithFormat:@"%@", theId];
             joke.id = theId;
             joke.datetime = now;
             
             
             //[jokeSvc createJoke:joke];
             
             
             [self.tableView reloadData];
             
             
             
             //self.greetingId.text = [values valueForKey:@"id"];
             //id forecastday = [simpleforecast valueForKey:@"forecastday"];
             //self.greetingId.text = [[theJoke objectForKey:@"id"] stringValue];
             //self.greetingContent.text = [theJoke objectForKey:@"joke"];
             
        
             
         }
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (![self connected])
    {
        // not connected
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network settings!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else
    {
        // connected, do some internet stuff
        
    }
    
    
    
    
    
    // jokeSvc = [[JokeSvcCache alloc] init];
	//jokeSvc = [[JokeSvcArchive alloc] init];
    //jokeSvc = [[JokeSvcSQLite alloc] init];
    jokeSvc = [[JokeSvcCoreData alloc] init];
    
     NSLog(@"Title %@", self.navigationItem.title );
    if ([self.navigationItem.title  isEqual: @"Hello Chuck Norris"]) {
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
    if(self.tableView.editing) {
        NSLog(@"editMode on");
    } else {
        NSLog(@"editMode off");
    }
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    Joke *joke = [[jokeSvc retrieveAllJokes] objectAtIndex:indexPath.row];
    [jokeSvc deleteJoke:joke];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    
}






-(UITableViewCell *) GetCellFromTableView:(UITableView*)tableView Sender:(id)sender {
    CGPoint pos = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:pos];
    return [tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[jokeSvc retrieveAllJokes] count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIndentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIndentifier];
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIndentifier];
        
    }
    
    Joke *joke = [[jokeSvc retrieveAllJokes] objectAtIndex:indexPath.row];
    
    // fix some formatting issues
    // from: http://stackoverflow.com/questions/9661690/user-regular-expression-to-find-replace-substring-in-nsstring
    NSError *error = nil;

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"&quot;" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:joke.theJoke options:0 range:NSMakeRange(0, [joke.theJoke length]) withTemplate:@"\""];
    joke.theJoke = modifiedString;
    
    
    //NSLog(@"%@", modifiedString);
    
    
    //JKG mistake in example code here
    //cell.textLabel.text = contact.name;
    //cell.textLabel.numberOfLines = 1; // dont set a specific # of lines
    //cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    // modified for core data, this worked prior
    // cell.textLabel.text = joke.description;
    
    
    
    cell.textLabel.text = joke.theJoke;
    
    
    // testing the sort order, display the datetime field
    //    from http://stackoverflow.com/questions/576265/convert-nsdate-to-nsstring
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    NSString *stringFromDate = [formatter stringFromDate:joke.datetime];
    cell.textLabel.text = stringFromDate;
    */
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue: ENTERED");
    NSLog(@"segue.identifier is %@",segue.identifier);
    
    if ([segue.identifier isEqualToString:@"showJokeDetail"]) {
        NSLog(@"prepareForSegue: ENTERED showJokeDetail");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JokeDetailViewController *destViewController = segue.destinationViewController;
        Joke *joke = [[jokeSvc retrieveAllJokes] objectAtIndex:indexPath.row];
        destViewController.jokeName = joke.theJoke;

    }
    
    if ([segue.identifier isEqualToString:@"showSearchDetail"]) {
        NSLog(@"prepareForSegue: ENTERED showSearchDetail");
        NSLog(@"text : %@",self.CaptureInformation.text);
        JokeSearchViewController *destViewController = segue.destinationViewController;
        destViewController.jokeID = self.CaptureInformation.text;

    }
    
    if ([segue.identifier isEqualToString:@"showPersonalizedDetail"]) {
        
        NSLog(@"prepareForSegue: ENTERED showPersonalizedDetail");
        NSLog(@"text1 : %@",self.CaptureInformation_first.text);
        NSLog(@"text2 : %@",self.CaptureInformation_last.text);
        PersonalizedViewController *destViewController = segue.destinationViewController;
        destViewController.nameFirst = self.CaptureInformation_first.text;
        destViewController.nameLast = self.CaptureInformation_last.text;
        [self.view endEditing:YES];
    }
    
    
    // THIS ONE NEEDS WORK TO MASSAGE THE VARIABLES
    /*
    if ([segue.identifier isEqualToString:@"SavePersonalized"]) {
        NSLog(@"prepareForSegue: ENTERED SavePersonalized");
        NSLog(@"id : %@",self.CaptureInformation_first.text);
        NSLog(@"text : %@",self.CaptureInformation_last.text);
        PersonalizedViewController *destViewController = segue.destinationViewController;
        destViewController.nameFirst = self.CaptureInformation_first.text;
        destViewController.nameLast = self.CaptureInformation_last.text;
    }
     */
    
    //
    
    if ([segue.identifier isEqualToString:@"ShowRapidJokes"]) {
        
        NSLog(@"prepareForSegue: ENTERED ShowRapidJokes");
        NSLog(@"count : %@",self.Count.text);
        
        RapidViewController *destViewController = segue.destinationViewController;
        destViewController.Count = self.Count.text;
        NSLog(@"prepareForSegue: EXITING");
        [self.view endEditing:YES];
    }
    
    
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}


-(IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];
}



@end
