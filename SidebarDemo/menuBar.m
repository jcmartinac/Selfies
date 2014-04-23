//
//  menuBar.m
//  Selfies
//
//  Created by Carlos Martín Acera on 14/04/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "menuBar.h"
#import "SWRevealViewController.h"


@interface menuBar ()

@end

@implementation menuBar

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
    
    self.title = @"Selfies App";
    
    // Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    
    //Elimina la sombra en el tabBar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.image = [[UIImage imageNamed:@"menuBt.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    self.navigationItem.rightBarButtonItem = NO;
    
    // Set the gesture
    if (self.revealViewController) {
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //if not loged go to loginview
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"] == NO) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:vc animated:YES completion:nil];
    }

}

-(void)viewDidAppear:(BOOL)animated{
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
