//
//  TableViewController.m
//  Central Bank
//
//  Created by Alexander Ignition on 02.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "TableViewController.h"
#import "CBClient.h"
#import "AITableViewDataSource.h"
#import "AITableViewDelegate.h"
#import "NoDataLable.h"
#import "NSDateFormatter+CBClient.h"

#import <AFNetworking/UIAlertView+AFNetworking.h>
#import <AFNetworking/UIRefreshControl+AFNetworking.h>


@interface TableViewController ()
@property (nonatomic, strong) AITableViewDataSource *dataSource;
@property (nonatomic, strong) AITableViewDelegate *tableViewDelegate;
@property (nonatomic, copy) NSDate *currentDate;
@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentDate = [NSDate date];
    [self tableViewDelegate];
    [self addButtons];
}

- (void)setCurrentDate:(NSDate *)date {
    self.navigationItem.prompt = date.description;
    _currentDate = date;
}

#pragma mark - UITableViewDataSource

- (AITableViewDataSource *)dataSource {
    if (_dataSource) {
        return _dataSource;
    }
    
    _dataSource = [[AITableViewDataSource alloc] initWitthItems:nil];
    self.tableView.dataSource = _dataSource;
    
    [_dataSource setCellForRowAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        static NSString *cellIdentifier = @"currency_cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        return cell;
    }];
    
    [_dataSource setConfigureCellAtIndexPath:^(UITableViewCell *cell, NSIndexPath *indexPath, CBCurrency *currency) {
        cell.textLabel.text = currency.name;
        cell.detailTextLabel.text = currency.value;
    }];
    
    [_dataSource setNoDataViewForFrame:^UIView *(CGRect frame) {
        return [[NoDataLable alloc] initWithFrame:frame];
    }];
    
    return _dataSource;
}

#pragma mark - UITableViewDelegate

- (AITableViewDelegate *)tableViewDelegate {
    if (_tableViewDelegate) {
        return _tableViewDelegate;
    }
    
    _tableViewDelegate = [[AITableViewDelegate alloc] initWitthDataSource:self.dataSource];
    self.tableView.delegate = _tableViewDelegate;
    
    [_tableViewDelegate setDidSelectRowAtIndexPath:^(UITableView *tableView, NSIndexPath *indexPath, CBCurrency *currency) {
        
        
        // TODO: 
        
        
    }];
    return _tableViewDelegate;
}

#pragma mark - Buttons

- (void)addButtons {
    self.refreshControl = [self createRefreshControl];
    self.navigationItem.rightBarButtonItem = [self refreshButton];
}

- (UIBarButtonItem *)refreshButton {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                         target:self
                                                         action:@selector(refreshAction:)];
}

- (UIRefreshControl *)createRefreshControl {
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self
                       action:@selector(refreshAction:)
             forControlEvents:UIControlEventValueChanged];
    return refreshControl;
}

#pragma mark - Action
        
- (void)refreshAction:(id)sender {
    [self currencyOnDate:self.currentDate];
}

#pragma mark - Networking

- (void)currencyOnDate:(NSDate *)date {
    
    __weak __typeof(self)weakSelf = self;
    NSURLSessionDataTask *task = [CB_Client currencyOnDate:date success:^(NSURLSessionDataTask *task, NSArray *currencies, NSDate *date) {
        [weakSelf responseCurrencies:currencies onDate:date];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)responseCurrencies:(NSArray *)currencies onDate:(NSDate *)date {
    self.dataSource.items = currencies;
    [self.tableView reloadData];
    self.refreshControl.attributedTitle =
    [[NSAttributedString alloc] initWithString:[NSDate date].description attributes:nil];
}

@end
