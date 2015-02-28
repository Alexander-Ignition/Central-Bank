//
//  CDCurrency.h
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

#import <Ono/ONOXMLDocument.h>

@interface CBCurrency : NSObject

+ (NSArray *)currenciesFromXML:(ONOXMLDocument *)XMLDocument;

- (instancetype)initWithXMLElement:(ONOXMLElement *)element;

@property (nonatomic, copy, readonly) NSString *ID;
@property (nonatomic, copy, readonly) NSNumber *numCode;
@property (nonatomic, copy, readonly) NSString *strCode;
@property (nonatomic, copy, readonly) NSNumber *nominal;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *value;

@end
