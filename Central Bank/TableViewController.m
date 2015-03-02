//
//  TableViewController.m
//  Central Bank
//
//  Created by Alexander Ignition on 02.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "TableViewController.h"
#import "CBClient.h"

#import <AFNetworking/UIAlertView+AFNetworking.h>
#import <AFNetworking/UIRefreshControl+AFNetworking.h>


@interface TableViewController ()
@property (nonatomic, copy) NSArray *currencies;
@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addButtons];
//    [self request];
}

- (void)request {
    __weak __typeof(self)weakSelf = self;
    NSURLSessionDataTask *task =
    [CB_Client currencyOnDate:nil success:^(NSURLSessionDataTask *task, NSArray *currencies, NSDate *date) {
        
        weakSelf.currencies = currencies;
        weakSelf.navigationItem.prompt = date.description;
        [weakSelf.tableView reloadData];
        weakSelf.refreshControl.attributedTitle =
        [[NSAttributedString alloc] initWithString:[NSDate date].description attributes:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"currency_cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CBCurrency *currency = self.currencies[indexPath.row];
    cell.textLabel.text = currency.name;
    cell.detailTextLabel.text = currency.value;
}

#pragma mark - Buttons

- (void)addButtons {
    [self addRefreshButton];
    [self addRefreshControl];
}

- (void)addRefreshButton {
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                  target:self
                                                  action:@selector(refreshAction:)];;
}

- (void)addRefreshControl {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self
                            action:@selector(refreshAction:)
                  forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Action

- (void)refreshAction:(id)sender {
    [self request];
}

@end
