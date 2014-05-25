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
    
    
    //JKG mistake in example code here
    //cell.textLabel.text = contact.name;
    cell.textLabel.numberOfLines = 5; // dont set a specific # of lines
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = joke.description;
    
    return cell;
}



@end
