//
//  CBModel.h
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

@class ONOXMLDocument, ONOXMLElement;

@interface CBModel : NSObject

+ (NSArray *)arrayFromXML:(ONOXMLDocument *)XMLDocument;

- (instancetype)initWithXMLElement:(ONOXMLElement *)element;

- (NSNumber *)numberFromString:(NSString *)string;

@end
