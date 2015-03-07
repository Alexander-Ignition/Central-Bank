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
    static CBClient *client = nil;
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
    return [self.sessionManager
            GET:[self URLStringForCurrencyOnDate:date]
            parameters:nil
            success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
                if (success) {
                    NSArray *currencies = [CBCurrency arrayFromXML:XMLDocument];
                    NSDate *responseDate = [XMLDocument.rootElement cb_slashDate];
                    success(task, currencies, responseDate);
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
    
    return [self.sessionManager
            GET:[self URLStringCurrencyID:currencyID fromDate:fromDate toDate:toDate]
            parameters:nil
            success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
                if (success) {
                    NSArray *records = [CBRecord arrayFromXML:XMLDocument];
                    NSDate *responseFromDate = [XMLDocument.rootElement cb_fromDate];
                    NSDate *responseToDate = [XMLDocument.rootElement cb_toDate];
                    success(task, records, responseFromDate, responseToDate);
                }
            } failure:failure];
}

#pragma mark - URL String

- (NSString *)URLStringForCurrencyOnDate:(NSDate *)date
{
    NSString *URLString = (self.language == CBClientLanguageEng) ? @"XML_daily_eng.asp" : @"XML_daily.asp";
    
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
