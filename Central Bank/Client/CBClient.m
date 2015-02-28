//
//  CBClient.m
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBClient.h"
#import "CBHTTPSessionManager.h"
#import "ONOXMLElement+CBClient.h"
#import "NSDateFormatter+CBClient.h"

@interface CBClient ()
@property (strong, nonatomic) CBHTTPSessionManager *sessionManager;
@end


@implementation CBClient

+ (CBClient *)sharedClient {
    static id client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [self new];
    });
    return client;
}

#pragma mark - AFHTTPSessionManager

- (CBHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [CBHTTPSessionManager new];
    }
    return _sessionManager;
}

- (NSURLSessionDataTask *)currency:(CBClientCurrencyBlock)success failure:(CBClientErrorBlock)failure {
    return [self currencyOnDate:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)currencyOnDate:(NSDate *)date
                                 success:(CBClientCurrencyBlock)success
                                 failure:(CBClientErrorBlock)failure
{
    NSDictionary *parameters = date ? @{@"date_req": [NSDateFormatter cb_requestStringFromDate:date]} : nil;
    
    return [self.sessionManager GET:@"XML_daily.asp" parameters:parameters success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        
        if (success) {
            success(task, [CBCurrency currenciesFromXML:XMLDocument], [XMLDocument.rootElement cb_date]);
        }
        
    } failure:failure];
}

@end
