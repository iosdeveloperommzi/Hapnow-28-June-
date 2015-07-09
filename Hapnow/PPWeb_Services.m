//
//  PPWeb_Services.m
//  -----------
//
//  Created by Abhishek Gangdeb on 30/07/13.
//  Copyright (c) 2013 Abhishek Gangdeb. All rights reserved.
//

#import "PPWeb_Services.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworking.h"
#import "ASINetworkQueue.h"
#import "Reachability.h"

#define KTimeOut 30

static NSOperationQueue *_af_imageRequestOperationQueue = nil;

@implementation PPWeb_Services
@synthesize responseData;
@synthesize delegate;


// create JSON from Dictionary
-(NSString*)getJSONFromDictionary:(NSDictionary*)pars
{
	@try
    {
		NSArray *arParDict=[pars allKeys];
		NSString *JSON=[NSString stringWithFormat:@"{\"%@\":\"%@\"",[arParDict objectAtIndex:0],[pars objectForKey:[arParDict objectAtIndex:0]]];
		for (int x=1; x<[arParDict count]; x++)
		{
            JSON= [JSON stringByAppendingFormat:@",\"%@\":\"%@\"",[arParDict objectAtIndex:x],[pars objectForKey:[arParDict objectAtIndex:x]]];
		}
		NSString * body = [JSON stringByAppendingFormat:@"}"];
		return body;
	}
	@catch (NSException * e)
    {
		NSLog(@"%@",e);
		return [NSString stringWithFormat:@""];
	}
	@finally
    {
		
	}
    
}

-(void)imageRequestOperation{
    
    if (!_af_imageRequestOperationQueue) {
    _af_imageRequestOperationQueue = [[NSOperationQueue alloc] init];
             [_af_imageRequestOperationQueue setMaxConcurrentOperationCount:8];
           }
}

-(void)createRequestWithUrl:(NSString *)urlStr getData:(NSString *)postData withDelegate:(id)dele
{
    NSLog(@"URL=%@",urlStr);
    self.delegate=dele;
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request setHTTPMethod:@"GET"];
    //[request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:contentType forHTTPHeaderField:@"Accept"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:KTimeOut];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             if (dele)
                                             {
                                                 NSLog(@"response == %@", JSON);
                                                 if ([JSON isKindOfClass:[NSDictionary class]] || [JSON isKindOfClass:[NSMutableDictionary class]])
                                                 {
                                                     [dele parseTheResponse:JSON];
                                                 }
                                                 else
                                                 {
                                                     [dele parseTheResponse:JSON];
                                                     NSLog(@"Success");
                                                 }
                                             }
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             NSLog(@"failure");
                                             [dele parseTheResponse:JSON];
                                         }
                                         ];
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [operation start];

}


-(void)createRequestWithUrl:(NSString *)urlStr withDelegate:(id)dele
{
    self.delegate=dele;
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request setHTTPMethod:@"GET"];
    //[request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:contentType forHTTPHeaderField:@"Accept"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:KTimeOut];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    { if (dele) { NSLog(@"response == %@", JSON);
        if ([JSON isKindOfClass:[NSDictionary class]] || [JSON isKindOfClass:[NSMutableDictionary class]])
        {
            [dele parseTheResponse:JSON];
        }
        else
        {
            [dele parseTheResponse:JSON]; NSLog(@"Success");
        }
    }
    }
                                         
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
         NSLog(@"failure"); [dele parseTheResponse:JSON];
    }
    ];
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [operation start];
}

-(void)createRequestWithUrl:(NSString *)urlStr postStringData:(NSString *)postData withDelegate:(id)dele
{
    self.delegate=dele;
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:contentType forHTTPHeaderField:@"Accept"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:KTimeOut];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             if (dele)
                                             {
                                                 if (TARGET_IPHONE_SIMULATOR) {

                                                 NSLog(@"response == %@", JSON);
                                                 }
                                                 if ([JSON isKindOfClass:[NSDictionary class]] || [JSON isKindOfClass:[NSMutableDictionary class]])
                                                 {
                                                     [dele parseTheResponse:JSON];
                                                 }
                                                 else
                                                 {
                                                     [dele parseTheResponse:JSON];
                                                     NSLog(@"Success");
                                                 }
                                             }
                                             
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             [dele parseTheFailureWithRequest:request];
                                             
                                             
                                         }
                                         ];
    
    [operation setQueuePriority:NSOperationQueuePriorityHigh];
    [operation start];
}


-(void)sendRequestInQueue:(NSString*)urlStr postStringData:(NSString *)postData withDelegate:(id)dele
{
    
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
	
    [networkQueue setRequestDidFinishSelector:@selector(requestComplete:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    ASIHTTPRequest *request;
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addRequestHeader:@"Accept" value:contentType];
    [request addRequestHeader:@"Content-Type" value:contentType];
    NSArray* urlComponent=[urlStr componentsSeparatedByString:@"/"];
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[urlComponent lastObject],@"requestMethod",dele,@"delegate", nil]];
	[networkQueue addOperation:request];
    
    [networkQueue go];
}



- (void)requestComplete:(ASIHTTPRequest *)request
{
    SBJSON *json = [[SBJSON alloc] init];
	NSError* error;
    NSMutableDictionary* dict =[NSMutableDictionary dictionary];
    NSDictionary* responseDict=[json objectWithString:request.responseString error:&error];
    if (!responseDict) {
        responseDict=[NSDictionary dictionary];
    }
    NSString *Key=@"";
    for (NSString *str in [responseDict allKeys]) {
        Key=str;
    }
    if ([Key length]==0) {
        Key=[NSString stringWithFormat:@"%@Result",[request.userInfo objectForKey:@"requestMethod"]];
    }
    [dict setObject:responseDict forKey:Key];
    [dict setObject:[NSString stringWithFormat:@"%d",[networkQueue requestsCount]] forKey:@"pendingRequest"];
    [[request.userInfo objectForKey:@"delegate"] parseTheResponse:dict];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"connectLost");
	if ([networkQueue requestsCount]==0) {
        [[request.userInfo objectForKey:@"delegate"] parseTheFailureWithRequest:nil];
    }
}

-(void)createRequestWithUrlForPhotoPost:(NSString *)urlStr postData:(NSDictionary *)dic withDelegate:(id)dele
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    NSString* postData=[self getJSONFromDictionary:dic];
    
    [self sendRequestInQueue:urlStr postStringData:postData withDelegate:dele];
    [pool release];
    
}

-(void)createCustomRequestWithUrl:(NSString *)urlStr postStringData:(NSString *)postData withUserInfo:(NSString*)index ImageType:(NSString *)imageType delegate:(id)dele
{
    NSLog(@"%@",postData);
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request setHTTPMethod:@"GET"];
    [request setValue:contentType forHTTPHeaderField:@"Accept"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:30];
    __block int imageIndex = [index intValue];
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
                                                //                                              if ([imageType isEqualToString:@"productImage"])
     [dele my:image forIndex:imageIndex imageType:imageType];
                                                //                                              else if ([imageType isEqualToString:@"storeLogo"])
                                                //                                                  [dele my:image forIndex:imageIndex imageType:@"storeLogo"];
                                                //                                              else if ([imageType isEqualToString:@"storeImage"])
                                                //                                                  [dele my:image forIndex:imageIndex imageType:@"storeImage"];
                                                
     }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
     NSLog(@"failure");
    
    [dele myFailureRequest:request forIndex:imageIndex imageType:imageType];
        }];
    
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    
    
     [_af_imageRequestOperationQueue addOperation:operation];
    

}





-(void)createRequestWithUrl:(NSString *)urlStr postData:(NSDictionary *)dic withDelegate:(id)dele
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
   
    NSLog(@"Url Str %@",urlStr);
    self.delegate=dele;
	NSString* postData=[self getJSONFromDictionary:dic];
    
    NSLog(@"%@",postData);
    [self createRequestWithUrl:urlStr postStringData:postData withDelegate:dele];
    [pool release];

}
-(id)init
{
    if (self==[super init])
    {
        self.delegate=nil;
    }
    return self;
}
#pragma mark - Check For Internet Connection
-(BOOL)checkForInternetConnection
{
    Reachability *reach = [Reachability reachabilityForInternetConnection] ;
    
    NetworkStatus status = [reach currentReachabilityStatus];
    
    [self stringFromStatus:status];
    
    if (internetConn)
    {
        return YES;
        //        [self displayComposerSheet];
        
    }
    else
    {
        ALERT(@"Please check your internet connection");
       // [self AlertView:NSLocalizedString(@"No internet connectivity", nil) withRect:self.window.frame];
        //        UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"Petspot" message:@"No internet connectivity" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [al show];
        return NO;
    }
    
    //[kappDelegate RemoveAlertVIew];
    return NO;
    
}

-(BOOL)AlertcheckForInternetConnection
{
    Reachability *reach = [Reachability reachabilityForInternetConnection] ;
    
    NetworkStatus status = [reach currentReachabilityStatus];
    
    [self stringFromStatus:status];
    
    if (internetConn)
    {
        return YES;
        //        [self displayComposerSheet];
        
    }
    else
    {
        // [self AlertView:NSLocalizedString(@"No internet connectivity", nil) withRect:self.window.frame];
        //        UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"Petspot" message:@"No internet connectivity" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [al show];
        return NO;
    }
    
    //[kappDelegate RemoveAlertVIew];
    return NO;
    
}

#pragma Mark Check Network Status

-(void)stringFromStatus:(NetworkStatus)status
{
	NSString *string;
	switch(status)
	{
		case NotReachable:
			string =NSLocalizedString(@"Not Reachable", nil) ;
			internetConn=NO;
			break;
		case ReachableViaWiFi:
			string = NSLocalizedString(@"Reachable via WiFi",nil);
			internetConn=YES;
			break;
		case ReachableViaWWAN:
			string =NSLocalizedString(@"Reachable via WWAN",nil);
			internetConn=YES;
			break;
		default:
			string =NSLocalizedString(@"Unknown",nil);
			internetConn=YES;
			break;
	}
}


@end

