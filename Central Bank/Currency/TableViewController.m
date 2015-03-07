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
#import "NoDataLable.h"
#import "NSDateFormatter+CBClient.h"
#import "DetailViewController.h"
#import "CurrencyCell.h"

#import <AFNetworking/UIAlertView+AFNetworking.h>
#import <AFNetworking/UIRefreshControl+AFNetworking.h>


@interface TableViewController ()
@property (nonatomic, strong) AITableViewDataSource *dataSource;
@property (nonatomic, assign) CBClientLanguage language;
@property (nonatomic, weak) NSURLSessionDataTask *task;
@property (nonatomic, copy) NSDate *currentDate;
@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentDate = [NSDate date];
    self.language = CBClientLanguageRus;
    [self dataSource];
    [self addButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (UILabel *)titleLabel:(NSString *)title {
    UILabel *label = [UILabel new];
    label.font = [UIFont fontWithName:@"Palatino-Italic" size:22];
    label.text = title;
    [label sizeToFit];
    return label;
}

#pragma mark - Getters

- (CBClientLanguage)language {
    return CB_CLIENT.language;
}

#pragma mark - Setters

- (void)setLanguage:(CBClientLanguage)language {
    NSString *title = (language == CBClientLanguageEng) ? @"Currency" : @"Валюты";
    self.navigationItem.titleView = [self titleLabel:title];
    CB_CLIENT.language = language;
}

- (void)setTask:(NSURLSessionDataTask *)task {
    if (_task) {
        [_task cancel];
    }
    _task = task;
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)setCurrentDate:(NSDate *)date {
    _currentDate = date;
    self.navigationItem.prompt = [[NSDateFormatter cb_dotDateFormatter] stringFromDate:date];
}

#pragma mark - UITableViewDataSource

- (AITableViewDataSource *)dataSource {
    if (_dataSource) {
        return _dataSource;
    }
    
    _dataSource = [[AITableViewDataSource alloc] initWitthItems:nil];
    self.tableView.dataSource = _dataSource;
    
    [_dataSource setCellForRowAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *__unused indexPath, CBCurrency *currency) {
        static NSString *cellIdentifier = @"currency_cell";
        CurrencyCell *cell = (CurrencyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.name.text = currency.name;
        cell.nominal.text = [currency localizedNominal];
        cell.value.text = [currency localizedValue];
        return cell;
    }];
    
    [_dataSource setNoDataViewForFrame:^UIView *(CGRect frame) {
        return [[NoDataLable alloc] initWithFrame:frame];
    }];
    
    return _dataSource;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:[DetailViewController segueIdentifier]]) {
        DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (indexPath) {
            detailViewController.currency = self.dataSource.items[indexPath.row];
        }
    }
}

#pragma mark - Buttons

- (void)addButtons {
    self.refreshControl = [self createRefreshControl];
    self.navigationItem.leftBarButtonItem = [self languageButton];
    self.navigationItem.rightBarButtonItem = [self refreshButton];
}

- (UIBarButtonItem *)languageButton {
    return [[UIBarButtonItem alloc] initWithCustomView:[self languageSegmentedControl]];
}

- (UISegmentedControl *)languageSegmentedControl {
    UISegmentedControl *segmentedControl =
    [[UISegmentedControl alloc] initWithItems:@[ @"Rus", @"Eng" ]];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self
                         action:@selector(languageAction:)
               forControlEvents:UIControlEventValueChanged];
    return segmentedControl;
}

- (UIBarButtonItem *)refreshButton {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                         target:self
                                                         action:@selector(refreshAction:)];
}

- (UIBarButtonItem *)activityIndicatorButton {
    UIActivityIndicatorView *indicatorView =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView startAnimating];
    return [[UIBarButtonItem alloc] initWithCustomView:indicatorView];
}

- (UIRefreshControl *)createRefreshControl {
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.backgroundColor = [UIColor colorWithRed:22.f/255.f
                                                     green:122.f/255.f
                                                      blue:255.f/255.f
                                                     alpha:1.f];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(refreshAction:)
             forControlEvents:UIControlEventValueChanged];
    return refreshControl;
}

#pragma mark - Action
        
- (void)refreshAction:(id)sender {
    [self currencyOnDate:self.currentDate];
}

- (void)languageAction:(UISegmentedControl *)sender {
    self.language = (sender.selectedSegmentIndex == 0) ? CBClientLanguageRus : CBClientLanguageEng;
    [self currencyOnDate:self.currentDate];
}

#pragma mark - Networking

- (void)currencyOnDate:(NSDate *)date {
    self.navigationItem.rightBarButtonItem = [self activityIndicatorButton];
    
    __weak __typeof(self)weakSelf = self;
    self.task = [CB_CLIENT currencyOnDate:date success:^(NSURLSessionDataTask *__unused task, NSArray *currencies, NSDate *date) {
        [weakSelf responseCurrencies:currencies onDate:date];
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    }];
}

- (void)responseCurrencies:(NSArray *)currencies onDate:(NSDate *)date {
    self.navigationItem.rightBarButtonItem = [self refreshButton];
    self.dataSource.items = currencies;
    [self.tableView reloadData];
    
    NSString *dateString = [[NSDateFormatter cb_dotDateFormatter] stringFromDate:date];
    NSString *title = [NSString stringWithFormat:@"Last update: %@", dateString];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor] };
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:title
                                                                          attributes:attributes];
}

@end
