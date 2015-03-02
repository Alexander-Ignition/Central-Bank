//
//  CBRecord.h
//  Central Bank
//
//  Created by Александр Игнатьев on 02.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

@class ONOXMLElement;
@class ONOXMLDocument;

@interface CBRecord : NSObject

+ (NSArray *)arrayFromXML:(ONOXMLDocument *)XMLDocument;

- (instancetype)initWithXMLElement:(ONOXMLElement *)element;

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *ID;
@property (nonatomic, copy, readonly) NSNumber *nominal;
@property (nonatomic, copy, readonly) NSString *value;

@end
