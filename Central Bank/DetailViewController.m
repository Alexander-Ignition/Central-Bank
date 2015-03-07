//
//  DetailViewController.m
//  Central Bank
//
//  Created by Александр Игнатьев on 04.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "DetailViewController.h"
#import "NSDateFormatter+CBClient.h"
#import "CBClient.h"

#import <AFNetworking/UIAlertView+AFNetworking.h>
#import <BEMSimpleLineGraph/BEMSimpleLineGraphView.h>


@interface DetailViewController () <BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *graphView;
@property (weak, nonatomic) NSURLSessionDataTask *task;
@property (strong, nonatomic) NSArray *records;

@end


@implementation DetailViewController

+ (NSString *)segueIdentifier {
    return [NSString stringWithFormat:@"%@Segue", NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.currency.name;
    self.navigationItem.prompt = [self.currency localizedValue];
    
    NSDate *toDate = [NSDate date];
    NSDate *fromDate = [NSDate dateWithTimeIntervalSinceNow: -60 * 60 * 24 * 30 ];
    [self recordsCurrencyID:self.currency.ID fromDate:fromDate toDate:toDate];
    
    
    self.graphView.enableYAxisLabel  = YES;
    self.graphView.enableBezierCurve = YES;
    self.graphView.enablePopUpReport = YES;
    
    self.graphView.enableReferenceAxisFrame  = YES;
    self.graphView.enableReferenceXAxisLines = YES;
    self.graphView.enableReferenceYAxisLines = YES;
    
    self.graphView.colorBackgroundXaxis = [UIColor whiteColor];
    self.graphView.colorBackgroundYaxis = [UIColor whiteColor];
    
}

#pragma mark - Setters

- (void)setTask:(NSURLSessionDataTask *)task {
    if (_task) {
        [_task cancel];
    }
    _task = task;    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

#pragma mark - BEMSimpleLineGraphDelegate

- (BOOL)lineGraph:(BEMSimpleLineGraphView *)graph alwaysDisplayPopUpAtIndex:(CGFloat)index {
    return YES;
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSInteger)numberOfYAxisLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 3;
}

#pragma mark - BEMSimpleLineGraphDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.records.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    CBRecord *record = self.records[index];
    return record.value.doubleValue;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    CBRecord *record = self.records[index];
    return [[NSDateFormatter cb_dateFormatter] stringFromDate:record.date];
}

#pragma mark - Networking

- (void)recordsCurrencyID:(NSString *)currencyID fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    __weak __typeof(self)weakSelf = self;
    self.task = [CB_CLIENT recordsCurrencyID:currencyID fromDate:fromDate toDate:toDate success:^(NSURLSessionDataTask *__unused task, NSArray *records, NSDate *fromDate2, NSDate *toDate2) {
        [weakSelf records:records fromDate:fromDate2 toDate:toDate2];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    }];
}

- (void)records:(NSArray *)records fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    self.records = records;
    [self.graphView reloadGraph];
}

@end
