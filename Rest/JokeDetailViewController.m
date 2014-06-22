//
//  JokeDetailViewController.m
//  Rest
//
//  Created by Josh Gray on 5/31/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "JokeDetailViewController.h"
#import "Joke.h"
#import "JokeSvcCache.h"

@interface JokeDetailViewController ()

@end

@implementation JokeDetailViewController

@synthesize jokeLabel;
@synthesize jokeName;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    jokeLabel.text = jokeName;
    
    CGRect labelFrame = CGRectMake(20, 300, 280, 150);
    UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    //[myLabel setBackgroundColor:[UIColor orangeColor]];
    
    NSString *labelText = jokeName;
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
