//
//  PPWeb_Services.h
//  -----
//
//  Created by Abhishek Gangdeb on 30/07/13.
//  Copyright (c) 2013 Abhishek Gangdeb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonClass.h"
@protocol parseTheResponse
-(void)parseTheResponse:(NSMutableDictionary *)dataDic;
-(void)parseTheFailureWithRequest:( NSURLRequest *)request;
-(void)parseTheFailureWithRequest:( NSURLRequest *)request withTimeStamp:(NSString *)time;

@end


@class ASINetworkQueue;
@interface PPWeb_Services : SingletonClass{
    
    NSMutableData *responseData;
    id <parseTheResponse> delegate;
    ASINetworkQueue *networkQueue;
    BOOL internetConn;

}

@property(nonatomic, retain)id <parseTheResponse> delegate;
@property(nonatomic, retain) NSMutableData *responseData;

//For lazy loading of images
-(void)imageRequestOperation;
-(void)my:(UIImage *)Image forIndex:(int)index imageType:(NSString*)imageType;
-(void)myFailureRequest:( NSURLRequest *)request forIndex:(int)index imageType:(NSString*)imageType;


-(void)createRequestWithUrl:(NSString *)urlStr withDelegate:(id)dele;

-(void)createRequestWithUrl:(NSString *)urlStr getData:(NSString *)postData withDelegate:(id)dele;
-(void)createRequestWithUrl:(NSString *)urlStr postData:(NSDictionary *)dic withDelegate:(id)dele;
-(NSString*)getJSONFromDictionary:(NSDictionary*)pars;
-(void)createRequestWithUrl:(NSString *)urlStr postStringData:(NSString *)postData withDelegate:(id)dele;
-(void)createCustomRequestWithUrl:(NSString *)urlStr postStringData:(NSString *)postData withUserInfo:(NSString*)index ImageType:(NSString *)imageType delegate:(id)dele;


-(void)sendRequestInQueue:(NSString*)urlStr postStringData:(NSString *)postData withDelegate:(id)dele;
-(void)createRequestWithUrlForPhotoPost:(NSString *)urlStr postData:(NSDictionary *)dic withDelegate:(id)dele;
-(BOOL)checkForInternetConnection;
-(BOOL)AlertcheckForInternetConnection;

@end

