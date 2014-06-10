//
//  TFSpreadCellDefault1.m
//  BMS
//
//  Created by Terry  on 14-6-9.
//  Copyright (c) 2014年 ED. All rights reserved.
//

#import "TFSpreadCellDefault1.h"

@implementation TFSpreadCellDefault1

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)onItemSelectedAtIndex:(NSInteger)index {
    [self.selectDict setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",index]];

    self.clearButton.hidden = NO;
    [self.clearButton setTitle:self.items[index] forState:UIControlStateNormal];
}

- (void)loadItemView:(TFItemView *)itemView index:(NSInteger)index {
    [itemView.agentButton setTitle:self.items[index] forState:UIControlStateNormal];
    itemView.agentButton.selected = [self.selectDict[[NSString stringWithFormat:@"%d",index]] boolValue];
}

@end
