//
//  LLAlertView.m
//  dingdingbao
//
//  Created by LYPC on 2018/4/8.
//  Copyright © 2018年 shilinde. All rights reserved.
//

#import "LLAlertView.h"

// 操作系统版本号
#define IOS_VERSIO ([[[UIDevice currentDevice] systemVersion] floatValue])

// 是否横竖屏
// 用户界面横屏了才会返回YES
#define IS_LANDSCAP UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])

// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_w (IOS_VERSIO >= 8.0 ? [[UIScreen mainScreen] bounds].size.width : (IS_LANDSCAP ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width))

// 屏幕高度，会根据横竖屏的变化而变化
#define SCREEN_h (IOS_VERSIO >= 8.0 ? [[UIScreen mainScreen] bounds].size.height : (IS_LANDSCAP ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height))

#define YFColor(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation LLAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle {
    if (self = [super initWithFrame:CGRectMake(35, 0, SCREEN_w-35*2, 165)]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.bgView.hidden = YES;
        self.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        if ([title isEqualToString:@""] || title == nil) {
            self.titleLabel.frame = CGRectZero;
        }else {
            self.titleLabel.text = title;
        }
        self.messageLabel.text = message;
        CGSize baseSize = CGSizeMake(SCREEN_w-35*2, CGFLOAT_MAX);
        CGSize messageSize = [self.messageLabel sizeThatFits:baseSize];
        CGFloat messageH = (messageSize.height>80 ? messageSize.height : 80);
        self.messageLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.frame)-20, (messageH>SCREEN_h-40-51 ? SCREEN_h-40-51 : messageH));
        self.line.frame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), CGRectGetWidth(self.frame), 1);
        CGFloat btnX = CGRectGetMaxY(self.messageLabel.frame)+1;
        CGFloat leftBtnW = 0;
        CGFloat leftBtnH = 0;
        CGFloat rightBtnW = 0;
        if (([leftBtnTitle isEqualToString:@""] || title == nil) && ([rightBtnTitle isEqualToString:@""] || rightBtnTitle == nil)) {
            // 没有取消和确定按钮
            leftBtnW = 0;
            leftBtnH = 0;
            rightBtnW = 0;
            btnX = CGRectGetMaxY(self.messageLabel.frame);
        }else if (!([leftBtnTitle isEqualToString:@""] || title == nil) && ([rightBtnTitle isEqualToString:@""] || rightBtnTitle == nil)) {
            // 有取消 无确定按钮
            leftBtnW = CGRectGetWidth(self.frame);
            leftBtnH = 50;
            rightBtnW = 0;
        }else if (([leftBtnTitle isEqualToString:@""] || title == nil) && !([rightBtnTitle isEqualToString:@""] || rightBtnTitle == nil)) {
            // 无取消 有确定按钮
            leftBtnW = 0;
            leftBtnH = 50;
            rightBtnW = CGRectGetWidth(self.frame);
        }else if (!([leftBtnTitle isEqualToString:@""] || title == nil) && !([rightBtnTitle isEqualToString:@""] || rightBtnTitle == nil)) {
            // 有取消 有确定按钮
            leftBtnW = CGRectGetWidth(self.frame)*0.5;
            leftBtnH = 50;
            rightBtnW = CGRectGetWidth(self.frame)*0.5;
        }
        self.leftBtn.frame = CGRectMake(0, btnX, leftBtnW, leftBtnH);
        self.rightBtn.frame = CGRectMake(CGRectGetMaxX(self.leftBtn.frame), btnX, rightBtnW, 50);
        [self.leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
        [self.rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
        self.frame = CGRectMake(35, 0, SCREEN_w-35*2, CGRectGetMaxY(self.leftBtn.frame));
        self.center = self.bgView.center;
        self.delegate = delegate;
    }
    return self;
}

/**
 展示alertview
 */
- (void)showAlertView {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.hidden = NO;
        self.hidden = NO;
        self.bgView.alpha = 0.45;
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

/**
 关闭alertview
 */
- (void)cancelAlertView {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
    if ([self.delegate respondsToSelector:@selector(llAlertViewClickedBgViewActon:)]) {
        [self.delegate llAlertViewClickedBgViewActon:self];
    }
}

- (void)clickLeftBtnAction:(UIButton *)sender {
    [self cancelAlertView];
    if ([self.delegate respondsToSelector:@selector(llAlertView:clickedButtonAtIndex:)]) {
        [self.delegate llAlertView:self clickedButtonAtIndex:0];
    }
}

- (void)clickRightBtnAction:(UIButton *)sender {
    [self cancelAlertView];
    if ([self.delegate respondsToSelector:@selector(llAlertView:clickedButtonAtIndex:)]) {
        [self.delegate llAlertView:self clickedButtonAtIndex:1];
    }
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_w, SCREEN_h)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        _bgView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAlertView)];
        [_bgView addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = YFColor(0x3590ed);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.frame)-20, 80)];
        _messageLabel.text = @"";
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textColor = YFColor(0x434343);
        [self addSubview:_messageLabel];
        self.line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_messageLabel.frame), CGRectGetWidth(self.frame), 1)];
        self.line.backgroundColor = YFColor(0xd5d5d5);
        [self addSubview:self.line];
    }
    return _messageLabel;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame)+1, CGRectGetWidth(self.frame)*0.5, 50);
        [_leftBtn setTitle:@"" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:YFColor(0x434343) forState:UIControlStateNormal];
        [_leftBtn setBackgroundColor:[UIColor whiteColor]];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_leftBtn addTarget:self action:@selector(clickLeftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(CGRectGetMaxX(self.leftBtn.frame), CGRectGetMaxY(self.messageLabel.frame)+1, CGRectGetWidth(self.frame)*0.5, 50);
        [_rightBtn setTitle:@"" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setBackgroundColor:YFColor(0x3590ed)];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_rightBtn addTarget:self action:@selector(clickRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (void)dealloc {
//    NSLog(@"没了");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
