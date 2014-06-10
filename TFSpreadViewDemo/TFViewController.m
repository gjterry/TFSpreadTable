//
//  CompleteUserInfoViewController.m
//  RegisteDemo
//
//  Created by Terry  on 14-6-5.
//  Copyright (c) 2014年 EDoctor. All rights reserved.
//

#import "TFSpreadTableView.h"

#import "TFViewController.h"

@interface TFViewController () <TFSpreadTableViewDataSource,TFSpreadTableViewDelegate>

@property (nonatomic, retain) NSMutableArray *spreadArray;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSArray *topDepartments;


@property (weak, nonatomic) IBOutlet TFSpreadTableView *spreadTable;




@end

@implementation TFViewController

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSpreadArray];

}

- (void)setupSpreadArray {
    self.spreadArray = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < 3; i ++) {
        NSMutableDictionary *spreadDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [spreadDict setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"isSpread"]];
        [spreadDict setObject:[NSNumber numberWithInt:i] forKey:@"index"];
        [self.spreadArray addObject:spreadDict];
    }
    
    [self setupDataArray];
    
    [self.spreadTable reloadData];
}

- (void)setupDataArray {
    self.dataArray = [NSMutableArray arrayWithCapacity:self.spreadArray.count];
    for (int i = 0 ; i < self.spreadArray.count; i ++) {
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dataDict setObject:@[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7"] forKey:@"data"];

        [self.dataArray addObject:dataDict];
    }
    
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    BOOL isSpread = [self.spreadArray[index][@"isSpread"] boolValue];
    if (isSpread) {
        return 193.f;
    }else
        return 50.f;
}

- (NSInteger)numberOfCellInSpreadTableView:(TFSpreadTableView *)spreadTableView {
    return self.spreadArray.count;
}

- (TFSpreadCell *)spreadTableView:(TFSpreadTableView *)spreadTableView cellForRowAtIndex:(NSInteger)index {
    TFSpreadCell *cell = [[NSBundle mainBundle]loadNibNamed:@"TFSpreadCell" owner:self options:nil][index];
    cell.spreadDict  = self.spreadArray[index];
    cell.dataDict = self.dataArray[index];
    cell.masterViewController = self;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    tapGesture.delegate = (id <UIGestureRecognizerDelegate>)self;
    [cell.headerView addGestureRecognizer:tapGesture];
    return cell;
}

- (void)didTap:(UITapGestureRecognizer *)gesture {
    TFSpreadCell *cell =  (TFSpreadCell *)gesture.view.superview;
    NSMutableDictionary *dict = (NSMutableDictionary *)cell.spreadDict;
    [dict setObject:[NSNumber numberWithBool:![dict[@"isSpread"] boolValue]] forKey:@"isSpread"];
    [self.spreadTable reloadRowAtIndex:[dict[@"index"] integerValue]];
}



@end
