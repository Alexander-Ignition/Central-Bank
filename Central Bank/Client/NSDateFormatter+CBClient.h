//
//  NSDateFormatter+CBClient.h
//  Central Bank
//
//  Created by Александр Игнатьев on 28.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

@interface NSDateFormatter (CBClient)

+ (instancetype)cb_responseDateFormatter;
+ (instancetype)cb_requestDateFormatter;

+ (NSDate *)cb_responseDateFromString:(NSString *)string;
+ (NSDate *)cb_requestDateFromString:(NSString *)string;

+ (NSString *)cb_requestStringFromDate:(NSDate *)date;

@end
