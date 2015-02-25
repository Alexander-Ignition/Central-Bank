//
//  ViewController.m
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "ViewController.h"
#import "CBClient.h"

#import <AFNetworking/UIAlertView+AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLSessionDataTask *task = [CB_Client GETSuccess:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        
        [XMLDocument.rootElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
            [element.children enumerateObjectsUsingBlock:^(ONOXMLElement *element2, NSUInteger idx, BOOL *stop) {
                //
            }];
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
