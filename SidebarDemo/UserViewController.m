//
//  UserViewController.m
//  Selfies
//
//  Created by Carlos Martín Acera on 22/04/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

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
    
    // 2. Set the various properties
    UILabel *nameLabel = (UILabel *)[self.view viewWithTag:100];
    nameLabel.text =  [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    [nameLabel sizeToFit];
    
    UILabel *cityLabel = (UILabel *)[self.view viewWithTag:101];
    cityLabel.text =  [[NSUserDefaults standardUserDefaults] valueForKey:@"location"];
    
    FBProfilePictureView *profilePicture = (FBProfilePictureView *)[self.view viewWithTag:102];
    profilePicture.profileID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
    profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2;
    profilePicture.clipsToBounds = YES;
    profilePicture.layer.borderWidth = 1.5f;
    profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;

    }

- (void) awakeFromNib
{
    
    [self.tabBarItem initWithTitle: [NSString stringWithFormat: @""] image:[[UIImage imageNamed:@"user.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"user_focus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

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
