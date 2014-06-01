//
//  RestViewController.m
//  Rest
//
//  Created by Josh Gray on 5/21/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "RestViewController.h"
#import "Joke.h"
#import "JokeSvcCache.h"
#import "JokeDetailViewController.h"

@interface RestViewController ()

@end

@implementation RestViewController

JokeSvcCache *jokeSvc = nil;

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
             joke.theId = [NSString stringWithFormat:@"%@", theId];
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
	jokeSvc = [[JokeSvcCache alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}



@end
