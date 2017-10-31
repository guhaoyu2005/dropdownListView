//
//  dropdownList.m
//  dropdownList
//
//  Created by Haoyu Gu on 2016-03-29.
//  Copyright © 2016 Haoyu Gu. All rights reserved.
//

#import "dropdownList.h"

@interface dropdownList() <UITableViewDataSource , UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *data;

@property (nonatomic) BOOL drawed;

@end

static NSString * const TAG_TABLE_VIEW_CELL = @"tableViewCellId";
static NSUInteger const CELL_HEIGHT = 50;

@implementation dropdownList

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        self.drawed = NO;
    }
    return self;
}

- (id)initWithData:(NSArray*)data {
    if (self = [super init]) {
        self.drawed = NO;
        [self showWithData:data];
    }
    return self;
}

- (void)drawElements {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/2);
    self.backgroundColor = [UIColor clearColor];
    self.tableView = [[UITableView alloc] init];
    [self.tableView setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self addSubview:self.tableView];
    
    self.drawed = YES;
}

- (void)setHeaderOffset:(CGPoint)offset {
    self.tableView.frame = CGRectMake(offset.x, offset.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
}

- (void)showWithData:(NSArray *)data {
    self.data = data;
    if (!self.drawed) {
        [self drawElements];
    }
    [self.tableView reloadData];
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^(){
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y,
                                          self.tableView.frame.size.width, ([self.data count]*CELL_HEIGHT <= self.frame.size.height)? [self.data count]*CELL_HEIGHT:self.frame.size.height);
    }   completion:^(BOOL finished){
        if (finished) {
            [self.tableView reloadData];
        }
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^(){
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y,
                                          self.tableView.frame.size.width, 10);
    }   completion:^(BOOL finished){
        if (finished) {
            self.hidden= YES;
        }
    }];
}

- (void)remove {
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CGFloat newHeight = ([self.data count]*CELL_HEIGHT <= self.frame.size.height)? [self.data count]*CELL_HEIGHT: self.frame.size.height;
    if (self.tableView.frame.size.height != newHeight) {
        [UIView animateWithDuration:0.25 animations:^(){
            self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, newHeight);
        }];
    }
    
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:TAG_TABLE_VIEW_CELL];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAG_TABLE_VIEW_CELL];
    }
    
    //cell.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 5);
    
    [cell.textLabel setText:self.data[indexPath.row]];
    //[cell.detailTextLabel setText:@"Detail"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate dropdownListSelectedAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
