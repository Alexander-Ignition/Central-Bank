//
//  NSDateFormatter+CBClient.m
//  Central Bank
//
//  Created by Александр Игнатьев on 28.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NSDateFormatter+CBClient.h"

@implementation NSDateFormatter (CBClient)

+ (instancetype)cb_dotDateFormatter { // "28.02.2015"
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"dd.MM.yy";
    });
    return formatter;
}

+ (instancetype)cb_slashDateFormatter { // "28/02/2015"
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"dd/MM/yyyy";
    });
    return formatter;
}

+ (instancetype)cb_dateFormatter { // "28"
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"dd";
    });
    return formatter;
}

@end
