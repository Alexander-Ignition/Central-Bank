//
//  CBClient.h
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//
//  Doc: http://www.cbr.ru/scripts/Root.asp?PrtId=SXML
//

@import Foundation;

#import "CBCurrency.h"
#import "CBRecord.h"

typedef NS_ENUM(NSUInteger, CBClientLanguage) {
    CBClientLanguageRus,
    CBClientLanguageEng,
};

typedef void (^CBClientCurrencyBlock)(NSURLSessionDataTask *task, NSArray *currencies, NSDate *date);
typedef void (^CBClientRecordsBlock)(NSURLSessionDataTask *task, NSArray *records, NSDate *fromDate, NSDate *toDate);
typedef void (^CBClientErrorBlock)(NSURLSessionDataTask *task, NSError *error);

#define CB_CLIENT [CBClient sharedClient]

@interface CBClient : NSObject

@property (nonatomic, assign) CBClientLanguage language;

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)currencyOnDate:(NSDate *)date
                                 success:(CBClientCurrencyBlock)success
                                 failure:(CBClientErrorBlock)failure;

- (NSURLSessionDataTask *)recordsCurrencyID:(NSString *)currencyID
                                   fromDate:(NSDate *)fromDate
                                     toDate:(NSDate *)toDate
                                    success:(CBClientRecordsBlock)success
                                    failure:(CBClientErrorBlock)failure;

@end
