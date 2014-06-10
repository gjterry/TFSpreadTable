//
//  TFSpreadCell.h
//  RegisteDemo
//
//  Created by Terry  on 14-6-5.
//  Copyright (c) 2014年 EDoctor. All rights reserved.
//

#import "TFItemView.h"

#import "iCarousel.h"

#import <UIKit/UIKit.h>

@interface TFSpreadCell : UIView <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, weak) IBOutlet iCarousel *itemView;

@property (nonatomic, weak) IBOutlet UIView *containerView;

@property (nonatomic, weak) IBOutlet UIView *headerView;

@property (nonatomic, weak) IBOutlet UIButton *clearButton;

@property (nonatomic, assign) NSDictionary  *spreadDict;

@property (nonatomic, retain) NSDictionary *dataDict;

@property (nonatomic, retain) NSMutableDictionary *selectDict;

@property (nonatomic, retain) NSArray *items;

@property (nonatomic, retain) UIViewController *masterViewController;

- (void)onItemSelectedAtIndex:(NSInteger)index;

- (void)loadItemView:(TFItemView *)itemView index:(NSInteger)index;

@end
