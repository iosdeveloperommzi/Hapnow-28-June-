//
//  ViewController.m
//  Hapnow
//
//  Created by Gurpreet Singh on 6/15/15.
//  Copyright (c) 2015 Ommzi. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(24, 512, 273, 30)];
  //  loginButton.center = self.view.center;
    loginButton.delegate=self;
    [self.view addSubview:loginButton];

}

- (void)viewWillAppear:(BOOL)animated{

}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{


    NSLog(@"Login Successfully");
    
    
    [[UIApplication sharedApplication]delegate].window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];


}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{


    NSLog(@"Logout Successfully");

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
