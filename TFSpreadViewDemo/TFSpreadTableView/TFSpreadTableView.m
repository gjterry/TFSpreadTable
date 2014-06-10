//
//  TFSpreadTableView.m
//  RegisteDemo
//
//  Created by Terry  on 14-6-5.
//  Copyright (c) 2014年 EDoctor. All rights reserved.
//

#import "TFSpreadTableView.h"

@interface TFSpreadTableView ()

@property (nonatomic, retain) UIScrollView *contentView;

@property (nonatomic, retain) NSMutableDictionary *itemViews;

@end

@implementation TFSpreadTableView

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)setDataSource:(id<TFSpreadTableViewDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        if (_dataSource) {
            [self reloadData];
        }
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addCell:(TFSpreadCell *)cell withHeight:(CGFloat)height {
    TFSpreadCell *lastCell = [[self.itemViews allValues]lastObject];
    if (!lastCell) {
        cell.frame = CGRectMake(0, 0, cell.frame.size.width, height);
        [self.contentView addSubview:cell];
    }else {
        cell.frame = CGRectMake(cell.frame.origin.x, CGRectGetMaxY(lastCell.frame), cell.frame.size.width, height);
        [self.contentView insertSubview:cell belowSubview:lastCell];
    }
    
    [self layoutCell:cell andHeight:height];
}

- (void)reloadRowAtIndex:(NSInteger)index {
    CGFloat nowHeight = [self.delegate heightForRowAtIndex:index];
    TFSpreadCell *toChangeCell = [self.itemViews allValues][index];
    [UIView beginAnimations:[NSString stringWithFormat:@"%d",index] context:NULL];
    [UIView setAnimationDuration:0.4];
    if (nowHeight < toChangeCell.headerView.bounds.size.height + toChangeCell.headerView.bounds.size.height) { // 隐藏
        [UIView setAnimationDelegate:nil];
        toChangeCell.containerView.hidden = YES;
    }else {
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    }
    toChangeCell.frame = CGRectMake(toChangeCell.frame.origin.x, toChangeCell.frame.origin.y, toChangeCell.frame.size.width, nowHeight);
    
    for (int i = index + 1; i < self.itemViews.allValues.count; i ++) {
        TFSpreadCell *cCell = [self.itemViews allValues][i];
        TFSpreadCell *pCell = [self.itemViews allValues][i - 1];
        cCell.frame = CGRectMake(cCell.frame.origin.x, CGRectGetMaxY(pCell.frame), cCell.frame.size.width, cCell.frame.size.height);
    }
    TFSpreadCell *lastCell = [[self.itemViews allValues]lastObject];
    self.contentView.contentSize = CGSizeMake(self.contentView.frame.size.width,  CGRectGetMaxY(lastCell.frame));
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    NSInteger index = [animationID integerValue];
    TFSpreadCell *toChangeCell = [self.itemViews allValues][index];
    CGFloat nowHeight = [self.delegate heightForRowAtIndex:index];
    [self layoutCell:toChangeCell andHeight:nowHeight];
}

- (void)layoutCell:(TFSpreadCell *)cell
         andHeight:(CGFloat)height {
    if (height < cell.headerView.bounds.size.height + cell.headerView.bounds.size.height) {
        cell.containerView.hidden = YES;
    }else {
        cell.containerView.hidden = NO;
    }
}

- (void)layoutSubviews {
    if (_numberOfItems > 0 && self.delegate) {
        for (int i = 0; i < _numberOfItems; i++) {

            CGFloat height = [self.delegate heightForRowAtIndex:i];
            
            TFSpreadCell *cell = [self.dataSource spreadTableView:self cellForRowAtIndex:i];
            
            [self addCell:cell withHeight:height];
            
            [self.itemViews setObject:cell forKey:[NSNumber numberWithInt:i]];
        }
        TFSpreadCell *lastCell = [[self.itemViews allValues]lastObject];
        self.contentView.contentSize = CGSizeMake(self.contentView.frame.size.width,  CGRectGetMaxY(lastCell.frame));
    }
}

- (void)reloadData {
    for (UIView *view in [self.contentView subviews])
        [view removeFromSuperview];

    if (!_dataSource || !_contentView) return;
    
    _numberOfItems = [self.dataSource numberOfCellInSpreadTableView:self];
    
    self.itemViews = [NSMutableDictionary dictionary];

    [self setNeedsLayout];
}


@end
