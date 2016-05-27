//
//  ShowTextCell.m
//  Animations
//
//  Created by YouXianMing on 16/4/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ShowTextCell.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "ShowTextModel.h"

@interface ShowTextCell ()

@property (nonatomic, strong) UILabel  *normalLabel;
@property (nonatomic, strong) UILabel  *expendLabel;
@property (nonatomic, strong) UIView   *line;
@property (nonatomic, strong) UIView   *stateView;

@end

@implementation ShowTextCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    self.line                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    self.line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.contentView addSubview:self.line];
    
    self.stateView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 13, 2, 15)];
    self.stateView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.stateView];
    
    self.normalLabel               = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Width - 20, 0)];
    self.normalLabel.numberOfLines = 3.f;
    self.normalLabel.textColor     = [UIColor grayColor];
    self.normalLabel.font          = [UIFont HeitiSCWithFontSize:14.f];
    [self.contentView addSubview:self.normalLabel];
    
    self.expendLabel               = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Width - 20, 0)];
    self.expendLabel.numberOfLines = 0;
    self.expendLabel.textColor     = [UIColor blackColor];
    self.expendLabel.font          = [UIFont HeitiSCWithFontSize:14.f];
    [self.contentView addSubview:self.expendLabel];
}

- (void)changeState {

    ShowTextModel   *model   = self.dataAdapter.data;
    CellDataAdapter *adapter = self.dataAdapter;
    
    if (adapter.cellType == kShowTextCellNormalType) {
        
        adapter.cellType = kShowTextCellExpendType;
        
        adapter.cellHeight = model.expendStringHeight;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        [self expendState];
        
    } else {
    
        adapter.cellType = kShowTextCellNormalType;
        
        adapter.cellHeight = model.normalStringHeight;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        [self normalState];
    }
}

- (void)normalState {
 
    [UIView animateWithDuration:0.25f animations:^{
        
        self.normalLabel.alpha         = 1;
        self.expendLabel.alpha         = 0;
        self.stateView.backgroundColor = [UIColor grayColor];
    }];
}

- (void)expendState {

    [UIView animateWithDuration:0.25f animations:^{
        
        self.normalLabel.alpha         = 0;
        self.expendLabel.alpha         = 1;
        self.stateView.backgroundColor = [UIColor redColor];
    }];
}

- (void)loadContent {

    ShowTextModel   *model   = self.dataAdapter.data;
    CellDataAdapter *adapter = self.dataAdapter;
    
    if (adapter.cellType == kShowTextCellNormalType) {
        
        self.normalLabel.text  = model.inputString;
        self.normalLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.normalLabel.alpha = 1;
        [self.normalLabel sizeToFit];
        
        self.expendLabel.text  = model.inputString;
        self.expendLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.expendLabel.alpha = 0;
        [self.expendLabel sizeToFit];
        
        self.stateView.backgroundColor = [UIColor grayColor];
        
    } else {
    
        self.normalLabel.text  = model.inputString;
        self.normalLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.normalLabel.alpha = 0;
        [self.normalLabel sizeToFit];
        
        self.expendLabel.text  = model.inputString;
        self.expendLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.expendLabel.alpha = 1;
        [self.expendLabel sizeToFit];
        
        self.stateView.backgroundColor = [UIColor redColor];
    }
    
    if (self.indexPath.row == 0) {
        
        self.line.hidden = YES;
        
    } else {
    
        self.line.hidden = NO;
    }
}

- (void)selectedEvent {

    [self changeState];
}

@end
