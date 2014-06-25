//
//  PersonalizedSaveViewController.m
//  Rest
//
//  Created by Josh Gray on 6/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import "PersonalizedSaveViewController.h"
#import "Joke.h"
#import "JokeSvcCache.h"


@interface PersonalizedSaveViewController ()

@end

@implementation PersonalizedSaveViewController

@synthesize nameFirst;
@synthesize nameLast;


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
    NSLog(@"PersonalizedSaveViewController : viewDidLoad : ENTERED");
    [super viewDidLoad];
    
    
    
    

    
    
    
    
    
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
    
    
    
   }

@end