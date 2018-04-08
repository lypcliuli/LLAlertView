//
//  LLViewController.m
//  LLAlertView
//
//  Created by lypcliuli on 04/08/2018.
//  Copyright (c) 2018 lypcliuli. All rights reserved.
//

#import "LLViewController.h"
#import "LLAlertView.h"

@interface LLViewController () <LLAlertViewDelegate>

@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation LLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.leftBtn setBackgroundColor:[UIColor orangeColor]];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)show {
    LLAlertView *alertView = [[LLAlertView alloc] initWithTitle:@"" message:@"购买数量不能小于1，您是想从购物车中删除该物品吗？" delegate:self leftBtnTitle:@"取消" rightBtnTitle:@"删除"];
    alertView.tag = 111;
    [alertView showAlertView];
}

- (void)llAlertView:(LLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag != 111 && buttonIndex == 1) {
        NSLog(@"点击了删除");
    }
    
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 100, 300, 50);
        [_leftBtn setTitle:@"" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_leftBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
