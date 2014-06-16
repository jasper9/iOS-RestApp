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
#import "JokeSvcSQLite.h" // added june 15 2014


#import "JokeDetailViewController.h"
#import "JokeSearchViewController.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"


@interface RestViewController ()

@end

@implementation RestViewController

@synthesize jokeID;

//JokeSvcCache *jokeSvc = nil;
//JokeSvcArchive *jokeSvc = nil;
JokeSvcSQLite *jokeSvc = nil;



- (IBAction)fetchGreeting;
{
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
             
             Joke *joke = [[Joke alloc] init];
             joke.theJoke = theJoke;
             //joke.theId = [NSString stringWithFormat:@"%@", theId];
             //joke.id = [NSString stringWithFormat:@"%@", theId];
             joke.id = (int)theId;
             
             
             [jokeSvc createJoke:joke];
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
    jokeSvc = [[JokeSvcSQLite alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
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
    NSString *modifiedString = [regex stringByReplacingMatchesInString:joke.description options:0 range:NSMakeRange(0, [joke.description length]) withTemplate:@"\""];
    joke.theJoke = modifiedString;
    //NSLog(@"%@", modifiedString);
    
    
    //JKG mistake in example code here
    //cell.textLabel.text = contact.name;
    //cell.textLabel.numberOfLines = 1; // dont set a specific # of lines
    //cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = joke.description;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showJokeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JokeDetailViewController *destViewController = segue.destinationViewController;
        Joke *joke = [[jokeSvc retrieveAllJokes] objectAtIndex:indexPath.row];
        //destViewController.jokeName = [[jokeSvc retrieveAllJokes] objectAtIndex:indexPath.row];
        destViewController.jokeName = joke.description;
        //destViewController.joke = joke;
    }
    
    if ([segue.identifier isEqualToString:@"showSearchDetail"]) {
       // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JokeSearchViewController *destViewController = segue.destinationViewController;
        //Joke *joke = [[jokeSvc retrieveAllJokes] objectAtIndex:indexPath.row];
        //destViewController.jokeName = [[jokeSvc retrieveAllJokes] objectAtIndex:indexPath.row];
        destViewController.jokeID = self.jokeID.text;
        //destViewController.joke = joke;
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}


@end
