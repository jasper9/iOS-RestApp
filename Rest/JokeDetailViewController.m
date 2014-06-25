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
#import <Social/Social.h>

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
    
    CGRect labelFrame = CGRectMake(20, 200, 280, 150);
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

- (IBAction)btnTwitterSharing_Clicked:(id)sender {
    NSString *labelText = jokeName;
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheetOBJ setInitialText:labelText];
        [self presentViewController:tweetSheetOBJ animated:YES completion:nil];
    }
    else
    {   // from http://www.raywenderlich.com/21558/beginning-twitter-tutorial-updated-for-ios-6
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You cannot send a tweet right now, make sure you have at least one Twitter account configured."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)btnFacebookSharing_Clicked2:(id)sender {
    NSString *labelText = jokeName;
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbSheetOBJ setInitialText:labelText];
        [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
    }
    else
    {   // from http://www.raywenderlich.com/21558/beginning-twitter-tutorial-updated-for-ios-6
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You cannot post right now, make sure you have a Facebook account configured."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}
@end
