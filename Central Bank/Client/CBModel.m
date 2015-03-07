//
//  CBModel.m
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBModel.h"
#import <Ono/ONOXMLDocument.h>

@implementation CBModel

+ (NSArray *)arrayFromXML:(ONOXMLDocument *)XMLDocument
{
    NSArray *elements = XMLDocument.rootElement.children;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:elements.count];
    
    for (ONOXMLElement *element in elements) {
        id object = [[self alloc] initWithXMLElement:element];
        
        if (object) {
            [array addObject:object];
        }
    }
    return array;
}

- (instancetype)initWithXMLElement:(ONOXMLElement *)element {
    return [super init];
}

- (NSNumber *)numberFromString:(NSString *)string {
    NSString *floatString = [string stringByReplacingOccurrencesOfString:@"," withString:@"."];
    return @(floatString.floatValue);
}

@end
