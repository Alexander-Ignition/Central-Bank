//
//  CDCurrency.m
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBCurrency.h"
#import <AIKit/NSDictionary+AIKit.h>
#import "ONOXMLElement+CBClient.h"

@implementation CBCurrency

+ (NSArray *)currenciesFromXML:(ONOXMLDocument *)XMLDocument
{
    NSArray *elements = XMLDocument.rootElement.children;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:elements.count];
    
    for (ONOXMLElement *element in elements) {
        [array addObject:[[CBCurrency alloc] initWithXMLElement:element]];
    }
    return array;
}

- (instancetype)initWithXMLElement:(ONOXMLElement *)element {
    if (self = [super init]) {
        
        _ID      = [element.attributes ai_stringForKey:@"ID"];
        _numCode = [element cb_numberForKey:@"NumCode"];
        _strCode = [element cb_stringForKey:@"CharCode"];
        _nominal = [element cb_numberForKey:@"Nominal"];
        _name    = [element cb_stringForKey:@"Name"];
        _value   = [element cb_stringForKey:@"Value"];
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@ = %@", self.class, self, _name, _value];
}

@end
