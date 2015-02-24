//
//  ViewController.m
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "ViewController.h"
#import "CBClient.h"

#import <Ono/ONOXMLDocument.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CBClient sharedClient] GETSuccess:^(NSURLSessionDataTask *task, ONOXMLDocument *responseObject) {
        //
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
