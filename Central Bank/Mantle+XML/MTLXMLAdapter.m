//
//  MTLXMLAdapter.m
//  Central Bank
//
//  Created by Александр Игнатьев on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "MTLXMLAdapter.h"
#import <Mantle/MTLModel.h>

NSString * const MTLXMLAdapterErrorDomain = @"MTLXMLAdapterErrorDomain";


@interface MTLXMLAdapter ()
@property (nonatomic, strong, readonly) Class modelClass;
@end


@implementation MTLXMLAdapter

+ (id)modelOfClass:(Class)modelClass fromXMLElement:(ONOXMLElement *)XMLElement error:(NSError **)error {
    MTLXMLAdapter *adapter = [[self alloc] initWithXMLElement:XMLElement modelClass:modelClass error:error];
    return adapter.model;
}

- (id)initWithXMLElement:(ONOXMLElement *)XMLElement modelClass:(Class)modelClass error:(NSError **)error {
    NSParameterAssert(modelClass != nil);
    NSParameterAssert([modelClass isSubclassOfClass:MTLModel.class]);
    NSParameterAssert([modelClass conformsToProtocol:@protocol(MTLXMLSerializing)]);
    
    if (!XMLElement || ![XMLElement isKindOfClass:XMLElement.class]) {
        if (error != NULL) {
            NSDictionary *userInfo = @{
                NSLocalizedDescriptionKey: NSLocalizedString(@"Missing XML element", @""),
                NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"%@ could not be created because an invalid XML element dictionary was provided: %@", @""), NSStringFromClass(modelClass), XMLElement.class],
            };
            *error = [NSError errorWithDomain:MTLXMLAdapterErrorDomain code:MTLXMLAdapterErrorInvalidXMLElement userInfo:userInfo];
        }
        return nil;
    }
    
    if ([modelClass respondsToSelector:@selector(classForParsingXMLElement:)]) {
        modelClass = [modelClass classForParsingXMLElement:XMLElement];
        if (modelClass == nil) {
            if (error != NULL) {
                NSDictionary *userInfo = @{
                    NSLocalizedDescriptionKey: NSLocalizedString(@"Could not parse XML element", @""),
                    NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"No model class could be found to parse the XML element.", @"")
                };
                *error = [NSError errorWithDomain:MTLXMLAdapterErrorDomain code:MTLXMLAdapterErrorNoClassFound userInfo:userInfo];
            }
            return nil;
        }
        
        NSAssert([modelClass isSubclassOfClass:MTLModel.class], @"Class %@ returned from +classForParsingJSONDictionary: is not a subclass of MTLModel", modelClass);
        NSAssert([modelClass conformsToProtocol:@protocol(MTLXMLSerializing)], @"Class %@ returned from +classForParsingJSONDictionary: does not conform to <MTLJSONSerializing>", modelClass);
    }
    
    self = [super init];
    if (self == nil) return nil;
    
    _modelClass = modelClass;
//    _JSONKeyPathsByPropertyKey = [[modelClass JSONKeyPathsByPropertyKey] copy];
    
    return nil;
}

@end
