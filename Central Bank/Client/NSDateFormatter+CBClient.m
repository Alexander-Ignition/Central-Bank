//
//  NSDateFormatter+CBClient.m
//  Central Bank
//
//  Created by Александр Игнатьев on 28.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NSDateFormatter+CBClient.h"

@implementation NSDateFormatter (CBClient)

+ (NSDate *)cb_responseDateFromString:(NSString *)string {
    return [[self cb_responseDateFormatter] dateFromString:string];
}

+ (instancetype)cb_responseDateFormatter { // "28.02.2015"
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"dd.MM.yy";
    });
    return formatter;
}

+ (NSString *)cb_requestStringFromDate:(NSDate *)date {
    return [[self cb_requestDateFormatter] stringFromDate:date];
}

+ (instancetype)cb_requestDateFormatter { // "28/02/2015"
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"dd.MM.yy";
    });
    return formatter;
}


@end
