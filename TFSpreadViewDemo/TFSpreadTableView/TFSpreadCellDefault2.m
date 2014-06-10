//
//  TFSpreadCellDefault2.m
//  BMS
//
//  Created by Terry  on 14-6-9.
//  Copyright (c) 2014年 ED. All rights reserved.
//



#import "TFSpreadCellDefault2.h"

@interface TFSpreadCellDefault2 ()

@property (nonatomic, retain) UIPopoverController *popoverController;

@end

@implementation TFSpreadCellDefault2

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TextListSelectedNotification" object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(departmentSelected:) name:@"TextListSelectedNotification" object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)onItemSelectedAtIndex:(NSInteger)index {


    
}

- (void)loadItemView:(TFItemView *)itemView index:(NSInteger)index {

}

- (void)departmentSelected:(id)notification {
    
}

@end
