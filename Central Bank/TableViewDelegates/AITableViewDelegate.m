//
//  AITableViewDelegate.m
//  Central Bank
//
//  Created by Александр Игнатьев on 03.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "AITableViewDelegate.h"
#import "AITableViewDataSource.h"

@interface AITableViewDelegate ()
@property (nonatomic, copy) void (^didSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, id item);
@end

@implementation AITableViewDelegate

- (instancetype)initWitthDataSource:(AITableViewDataSource *)dataSource {
    if (self = [super init]) {
        _dataSource = dataSource;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectRowAtIndexPath) {
        id item = self.dataSource.items[indexPath.row];
        self.didSelectRowAtIndexPath(tableView, indexPath, item);
    }
}

@end
