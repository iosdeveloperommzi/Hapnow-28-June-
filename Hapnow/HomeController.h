//
//  HomeController.h
//  Hapnow
//
//  Created by Gurpreet Singh on 6/16/15.
//  Copyright (c) 2015 Ommzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *TabView;
@property (weak, nonatomic) IBOutlet UIImageView *NavImage;
@property (weak, nonatomic) IBOutlet UIView *HomeView;
@property (weak, nonatomic) IBOutlet UIView *AddEventView;
@property (weak, nonatomic) IBOutlet UIView *EventCreationView;

@property (weak, nonatomic) IBOutlet UIView *ProfileScreen;



- (IBAction)HomeButtonAction:(id)sender;
- (IBAction)AddButtonAction:(id)sender;
- (IBAction)ProfileBtnAction:(id)sender;

//Add event Screen.

- (IBAction)ButtonCommonAction:(id)sender;

// Create Event Screen
- (IBAction)createEventAction:(id)sender;
- (IBAction)individeualGroupsActions:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *EventType;
@property (weak, nonatomic) IBOutlet UITextField *eventTypeTxtF;
@property (weak, nonatomic) IBOutlet UITextField *startInTxtF;
@property (weak, nonatomic) IBOutlet UITextField *locationTxtF;
@property (weak, nonatomic) IBOutlet UIButton *individualsLbl;
@property (weak, nonatomic) IBOutlet UIButton *groupsLbl;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTxtF;
@property (weak, nonatomic) IBOutlet UIScrollView *CreateEventScr;
@property (weak, nonatomic) IBOutlet UITextField *timeTxtF;
@end
