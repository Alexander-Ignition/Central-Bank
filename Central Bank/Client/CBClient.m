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

+ (instancetype)sharedClient {
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

#pragma mark - Requests

- (NSURLSessionDataTask *)currencyOnDate:(NSDate *)date
                                 success:(CBClientCurrencyBlock)success
                                 failure:(CBClientErrorBlock)failure
{
    NSString *URLString = [self URLStringForCurrencyOnDate:date];
    
    return [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        if (success) {
            success(task, [CBCurrency currenciesFromXML:XMLDocument], [XMLDocument.rootElement cb_slashDate]);
        }
    } failure:failure];
}

- (NSURLSessionDataTask *)recordsCurrencyID:(NSString *)currencyID
                                   fromDate:(NSDate *)fromDate
                                     toDate:(NSDate *)toDate
                                    success:(CBClientRecordsBlock)success
                                    failure:(CBClientErrorBlock)failure;
{
    NSParameterAssert(currencyID != nil);
    NSParameterAssert(fromDate != nil);
    NSParameterAssert(toDate != nil);
    
    NSString *URLString = [self URLStringCurrencyID:currencyID fromDate:fromDate toDate:toDate];
    
    return [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        if (success) {
            success(task, [CBRecord arrayFromXML:XMLDocument], [XMLDocument.rootElement cb_fromDate], [XMLDocument.rootElement cb_toDate]);
        }
    } failure:failure];
}

#pragma mark - URL String

- (NSString *)URLStringForCurrencyOnDate:(NSDate *)date
{
    NSString *URLString = @"XML_daily.asp";
    if (date) {
        NSString *dateString = [[NSDateFormatter cb_slashDateFormatter] stringFromDate:date];
        URLString = [NSString stringWithFormat:@"%@?date_req=%@", URLString, dateString];
    }
    return URLString;
}

- (NSString *)URLStringCurrencyID:(NSString *)currencyID
                         fromDate:(NSDate *)fromDate
                           toDate:(NSDate *)toDate
{
    NSDateFormatter *formatter = [NSDateFormatter cb_slashDateFormatter];
    NSString *fromDateString = [formatter stringFromDate:fromDate];
    NSString *toDateString = [formatter stringFromDate:toDate];
    
    return [NSString stringWithFormat:@"XML_dynamic.asp?date_req1=%@&date_req2=%@&VAL_NM_RQ=%@",
            fromDateString, toDateString, currencyID];
}


@end
