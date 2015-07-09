//
//  Constants.h
//  RetailsBeacon
//
//  Created by Gurpreet Singh on 13/02/14.
//  Copyright (c) 2014 Gurpreet Singh. All rights reserved.
//

#ifndef RetailsBeacon_Constants_h
#define RetailsBeacon_Constants_h


#define FEQUAL(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define FEQUALZERO(a) (fabs(a) < FLT_EPSILON)
#define isPhone5 (SCREEN_HEIGHT > 480)
#define SCREEN_WIDTH			[[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT			[[UIScreen mainScreen] bounds].size.height
#define kAlertTitle                         @"Retail Store"

#define ALERT(msg) UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];\
NSLog(@"%@", msg);\
[alert show];\

#define ServerFailAlert [[[UIAlertView alloc] initWithTitle:@"" message:@"Service unavailable, Please try after some time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];

#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define kBaseServiceURL       @"http://dotnetstg2.seasiaconsulting.com/"


#define kServiceURL         @"BeaconAppQA/BeaconsApp.Services/BeaconsAppServices.svc/"

//#define kServiceURL          @"BeaconApp/BeaconsApp.Services/BeaconsAppServices.svc/"

//#define kServiceURL       @"BeaconAppUAT/BeaconsApp.Services/BeaconsAppServices.svc/"

#define kConfigureTypeID      @"1" // For Retail store

//Device Check
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#endif
