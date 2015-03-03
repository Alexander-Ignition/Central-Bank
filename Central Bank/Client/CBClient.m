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

- (NSURLSessionDataTask *)currencyOnDate:(NSDate *)date
                                 success:(CBClientCurrencyBlock)success
                                 failure:(CBClientErrorBlock)failure
{
    NSString *URLString = @"XML_daily.asp";
    
    if (date) {
        NSString *dateString = [[NSDateFormatter cb_slashDateFormatter] stringFromDate:date];
        URLString = [NSString stringWithFormat:@"%@?date_req=%@", URLString, dateString];
    }
    return [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        if (success) {
            success(task, [CBCurrency currenciesFromXML:XMLDocument], [XMLDocument.rootElement cb_date]);
        }
    } failure:failure];
}

- (NSURLSessionDataTask *)recordsCurrencyID:(NSString *)currencyID
                                   fromDate:(NSDate *)fromDate
                                     toDate:(NSDate *)toDate
                                    success:(CBClientRecordsBlock)success
                                    failure:(CBClientErrorBlock)failure;
{
    NSDictionary *parameters = @{ @"date_req1": @"",//[NSDateFormatter cb_requestStringFromDate:fromDate],
                                  @"date_req2": @"",//[NSDateFormatter cb_requestStringFromDate:toDate],
                                  @"VAL_NM_RQ": currencyID };
    
    return [self.sessionManager GET:@"XML_dynamic.asp" parameters:parameters success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        if (success) {
            success(task, [CBRecord arrayFromXML:XMLDocument], [XMLDocument.rootElement cb_fromDate], [XMLDocument.rootElement cb_toDate]);
        }
    } failure:failure];
}


@end
