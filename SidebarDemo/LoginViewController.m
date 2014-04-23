//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "LoginViewController.h"
#import "SWRevealViewController.h"
#import "CondicionesViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Login";
    
    //UIColor *myColor = [UIColor colorWithRed:(60.0 / 255.0) green:(184.0 / 255.0) blue:(120.0 / 255.0) alpha: 1];
    //self.view.backgroundColor = myColor;
    
    // Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    /*_sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.image = [[UIImage imageNamed:@"menuBt.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
*/
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    // Align the button in the center horizontally
    loginView.readPermissions = @[@"basic_info", @"email", @"user_likes"];
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 250);
    [self.view addSubview:loginView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    
    [[NSUserDefaults standardUserDefaults] setValue:user.id forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setValue:user.name forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setValue:user.location[@"name"] forKey:@"location"];
    /*
    NSString * storyboardName = @"MainStoryboard";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"menuBar"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:vc animated:YES completion:nil];
        
    }];
    */
    
    
    //[self performSegueWithIdentifier:@"menu" sender:self];
    
    
    // The url to our server endpoint
    NSString *url = @"http://www.virtualmind.es/clientes/selfies/index.php";
    
    // Like the post request I showed you before, I'm going to send the deviceId again, because that is generally useful for establishing
    
    //UIDevice *device = [UIDevice currentDevice];
    NSString *usuario = user.name;
    //NSString *type = @"register";
    //NSString *username= user.name;
    NSString *email= [user objectForKey:@"email"];
    NSString *name= user.first_name;
    NSString *surname= user.last_name;
    NSString *face_user_id= user.id;
    
    /*NSLog(@"FB user first name:%@",user.first_name);
    NSLog(@"FB user last name:%@",user.last_name);
    NSLog(@"FB user birthday:%@",user.birthday);
    NSLog(@"FB user location:%@",user.location);
    NSLog(@"FB user username:%@",user.username);
    NSLog(@"FB user gender:%@",[user objectForKey:@"gender"]);
    NSLog(@"email id:%@",[user objectForKey:@"email"]);
    NSLog(@"location:%@", [NSString stringWithFormat:@"Location: %@\n\n",
                           user.location[@"name"]]);
    */
    //NSString *post = [NSString stringWithFormat:@"usuario=", usuario];
    NSString *post = [NSString stringWithFormat:@"tag=register&username=%@&email=%@&name=%@&surname=%@&face_user_id=%@",usuario,email,name,surname,face_user_id];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    
    NSError *error;
    
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    
    NSLog(@"%@", results);
    
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);

}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
   // NSLog(@"logeado en fb");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //cuando está logeado pasamos a las condiciones
    [self performSegueWithIdentifier:@"condiciones" sender:self];

}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
    //[[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)viewDidAppear:(BOOL)animated{

}


// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
