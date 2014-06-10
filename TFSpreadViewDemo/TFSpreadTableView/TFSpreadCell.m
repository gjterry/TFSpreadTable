//
//  TFSpreadCell.m
//  RegisteDemo
//
//  Created by Terry  on 14-6-5.
//  Copyright (c) 2014年 EDoctor. All rights reserved.
//
#import "TFSpreadCell.h"

@interface TFSpreadCell () 

@end

@implementation TFSpreadCell

- (void)setDataDict:(NSDictionary *)dataDict {
    if (_dataDict!= dataDict) {
        _dataDict = dataDict;
        
        self.items = dataDict[@"data"];
    }

}

- (void)setItems:(NSArray *)items {
    if (_items != items) {
        _items = items;
        
        
        [self.itemView reloadData];
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.clearButton.hidden = YES;
}

- (void)setupSelectDict {
    self.selectDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i = 0; i < self.items.count; i ++) {
        [self.selectDict setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",i]];
    }
}

#pragma mark - iCarouselDelegate && iCarouselDataSource
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [self.items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    TFItemView *itemView;
    if (!view)
        view = [[[NSBundle mainBundle]loadNibNamed:@"TFItemView" owner:self options:nil]lastObject];
    
    itemView = (TFItemView *)view;

    [self loadItemView:itemView index:index];
    return view;
}

- (void)loadItemView:(TFItemView *)itemView index:(NSInteger)index {
    
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    [self setupSelectDict];
    
    [self onItemSelectedAtIndex:index];
//    [self.selectDict setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",index]];
//    
//    self.clearButton.hidden = NO;
//    [self.clearButton setTitle:self.items[index] forState:UIControlStateNormal];
    
    [self.itemView reloadData];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionSpacing:
            return value + 0.1;
            break;
        case iCarouselOptionArc:
            return value +0.5;
            break;
        default:
            return value;
            break;
    }
}

- (void)onItemSelectedAtIndex:(NSInteger)index {
    //子类实现
}

- (IBAction)onClearButtonTapped:(id)sender {
    self.clearButton.hidden = YES;
    
    [self setupSelectDict];
    
    [self.itemView reloadData];
}

@end
