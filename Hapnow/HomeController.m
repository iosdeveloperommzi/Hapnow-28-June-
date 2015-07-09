//
//  HomeController.m
//  Hapnow
//
//  Created by Gurpreet Singh on 6/16/15.
//  Copyright (c) 2015 Ommzi. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _HomeView.hidden=YES;
    _AddEventView.hidden=YES;
    _EventCreationView.hidden=YES;
    _ProfileScreen.hidden=YES;

    
    

    
    
    //Create Event
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    
    [_CreateEventScr addGestureRecognizer:singleTap];

    [_individualsLbl setBackgroundColor:[UIColor lightGrayColor]];
    [_groupsLbl setBackgroundColor:[UIColor whiteColor]];
    _individualsLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _groupsLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//TabView;
//HomeView;
//AddEventView;
//EventCreationView;


- (IBAction)HomeButtonAction:(id)sender {
    
    //_TabView.hidden=YES;
    _HomeView.hidden=YES;
    _AddEventView.hidden=YES;
    _EventCreationView.hidden=YES;
    _ProfileScreen.hidden=YES;

    
    
}
- (IBAction)AddButtonAction:(id)sender {
    
    //_TabView.hidden=YES;
    _HomeView.hidden=YES;
    _AddEventView.hidden=NO;
    _EventCreationView.hidden=YES;
    _ProfileScreen.hidden=YES;


}



- (IBAction)ProfileBtnAction:(id)sender {
    
    //_TabView.hidden=YES;
    _HomeView.hidden=YES;
    _AddEventView.hidden=YES;
    _EventCreationView.hidden=YES;
    _ProfileScreen.hidden=NO;


}

- (IBAction)ButtonCommonAction:(UIButton*)sender {
    
    int Tag= (int)sender.tag;
    
    
    switch (Tag) {
        case 201:
        {
            [self AddEvent:@"food_background.png" img:[UIImage imageNamed:@"food_background.png"]];
        }
            break;
        case 202:
        {
            [self AddEvent:@"DRINK" img:[UIImage imageNamed:@"drink_background.png"]];

        }
            break;
        case 203:
        {
            [self AddEvent:@"CAFE" img:[UIImage imageNamed:@"cafe_background.png"]];

        }
            break;
        case 204:
        {
            [self AddEvent:@"MOVIE" img:[UIImage imageNamed:@"movie_background.png"]];

        }
            break;
        case 205:
        {
            [self AddEvent:@"CONCERT" img:[UIImage imageNamed:@"concert_background.png"]];

        }
            break;
        case 206:
        {
            [self AddEvent:@"SPORT" img:[UIImage imageNamed:@"sport_background.png"]];

        }
            break;
        case 207:
        {
            [self AddEvent:@"OUTDOOR" img:[UIImage imageNamed:@"outdoor_background.png"]];

        }
            break;
        case 208:
        {
            [self AddEvent:@"GYM" img:[UIImage imageNamed:@"gym_background.png"]];

        }
            break;
        case 209:
        {
            [self AddEvent:@"STORE" img:[UIImage imageNamed:@"gym_background.png"]];

        }
            break;
        case 210:
        {
            [self AddEvent:@"SCHOOL" img:[UIImage imageNamed:@"school_background.png"]];

        }
            break;
        case 211:
        {
            [self AddEvent:@"OFFICE" img:[UIImage imageNamed:@"office_background.png"]];

        }
            break;
        case 212:
        {
            [self AddEvent:@"LIBRARY" img:[UIImage imageNamed:@"library_background.png"]];

        }
            break;
        case 213:
        {
            [self AddEvent:@"HOME" img:[UIImage imageNamed:@"home_background.png"]];

        }
            break;
        case 214:
        {
            [self AddEvent:@"LEISURE" img:[UIImage imageNamed:@"leisure_background.png"]];

        }
            break;
        case 215:
        {
            [self AddEvent:@"OTHER"  img:[UIImage imageNamed:@"other_background.png"]];

        }
            break;
        default:
            break;
    }
    
    
}

-(void)AddEvent:(NSString*)type img:(UIImage*)image{
    
    _AddEventView.hidden=YES;
    _EventCreationView.hidden=NO;
    
    
    _EventType.text=[NSString stringWithFormat:@"Event/%@",type];
    [_bgImage setImage:image];
    
    
}




- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

- (IBAction)createEventAction:(id)sender {
    
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"Hapnow" message:@"Coming Soon" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertV show];
    
    
}

- (IBAction)individeualGroupsActions:(UIButton*)sender {
    
    //Individual
    if (sender.tag==20006) {
        
        [_individualsLbl setBackgroundColor:[UIColor lightGrayColor]];
        [_groupsLbl setBackgroundColor:[UIColor whiteColor]];

    }else{
    
        [_individualsLbl setBackgroundColor:[UIColor whiteColor]];
        [_groupsLbl setBackgroundColor:[UIColor lightGrayColor]];

    }

}
@end
