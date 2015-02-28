//
//  MTLXMLAdapter.h
//  Central Bank
//
//  Created by Александр Игнатьев on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Ono/ONOXMLDocument.h>

@class MTLModel;

@protocol MTLXMLSerializing

@required
+ (NSDictionary *)XMLElementAttributesByPropertyKey;
+ (NSDictionary *)XMLElementChildTagByPropertyKey;

@optional
+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key;
+ (Class)classForParsingXMLElement:(ONOXMLElement *)XMLElement;

@end

extern NSString * const MTLXMLAdapterErrorDomain;

typedef NS_ENUM(NSUInteger, MTLXMLAdapterError) {
    MTLXMLAdapterErrorNoClassFound,
    MTLXMLAdapterErrorInvalidXMLElement,
    MTLXMLAdapterErrorInvalidJSONMapping,
};

@interface MTLXMLAdapter : NSObject

@property (nonatomic, strong, readonly) MTLModel<MTLXMLSerializing> *model;

//+ (id)modelOfClass:(Class)modelClass fromJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error;
//+ (NSArray *)modelsOfClass:(Class)modelClass fromJSONArray:(NSArray *)JSONArray error:(NSError **)error;
//
//+ (NSDictionary *)JSONDictionaryFromModel:(MTLModel<MTLXMLSerializing> *)model;
//+ (NSArray *)JSONArrayFromModels:(NSArray *)models;
//
//- (id)initWithJSONDictionary:(NSDictionary *)JSONDictionary modelClass:(Class)modelClass error:(NSError **)error;
//- (id)initWithModel:(MTLModel<MTLXMLSerializing> *)model;
//
//- (NSDictionary *)JSONDictionary;
//- (NSString *)JSONKeyPathForPropertyKey:(NSString *)key;

@end
