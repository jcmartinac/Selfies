
//
//  CondicionesViewController.m
//  Selfies
//
//  Created by Carlos Martín Acera on 22/04/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "CondicionesViewController.h"
#import "SWRevealViewController.h"
#import "menuBar.h"


@interface CondicionesViewController ()

@end

@implementation CondicionesViewController

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
    
    self.title = @"Terms";
    
    [self.navigationItem setHidesBackButton:YES];
   

    
   
}

- (void)viewDidAppear:(BOOL)animated
{
    /*if ([[NSUserDefaults standardUserDefaults] boolForKey:@"terms"] == YES) {
       // NSLog(@"%hhd", [[NSUserDefaults standardUserDefaults] boolForKey:@"terms"]);
        [self performSegueWithIdentifier:@"menu" sender:self];
    }*/
}

- (void) awakeFromNib
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)aceptarCondiciones:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"terms"];

    [self performSegueWithIdentifier:@"init" sender:self];
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [[storyboard instantiateViewControllerWithIdentifier:@"MainNav"] init];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentModalViewController:vc animated:YES];*/
}

@end
