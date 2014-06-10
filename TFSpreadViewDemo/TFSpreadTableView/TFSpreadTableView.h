//
//  TFSpreadTableView.h
//  RegisteDemo
//
//  Created by Terry  on 14-6-5.
//  Copyright (c) 2014年 EDoctor. All rights reserved.
//

#import "TFSpreadCell.h"

#import <UIKit/UIKit.h>

@protocol TFSpreadTableViewDelegate,TFSpreadTableViewDataSource;

@interface TFSpreadTableView : UIView {
    NSInteger _numberOfItems;
}



@property (nonatomic, assign) IBOutlet id <TFSpreadTableViewDelegate> delegate;

@property (nonatomic, assign) IBOutlet id <TFSpreadTableViewDataSource> dataSource;

- (void)reloadRowAtIndex:(NSInteger)index;

- (void)reloadData;

@end

@protocol TFSpreadTableViewDelegate <NSObject>

- (CGFloat)heightForRowAtIndex:(NSInteger)index;

@end

@protocol TFSpreadTableViewDataSource <NSObject>

- (NSInteger)numberOfCellInSpreadTableView:(TFSpreadTableView *)spreadTableView;

- (TFSpreadCell *)spreadTableView:(TFSpreadTableView *)spreadTableView cellForRowAtIndex:(NSInteger)index;

@end