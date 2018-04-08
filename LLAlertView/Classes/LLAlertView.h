//
//  LLAlertView.h
//  dingdingbao
//
//  Created by LYPC on 2018/4/8.
//  Copyright © 2018年 shilinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLAlertView;

@protocol LLAlertViewDelegate <NSObject>

@optional

/**
 点击取消/确定

 @param alertView alertView
 @param buttonIndex 按钮tag：左0 右1
 */
- (void)llAlertView:(LLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@optional

/**
 点击背景

 @param alertView alertView
 */
- (void)llAlertViewClickedBgViewActon:(LLAlertView *)alertView;

@end

@interface LLAlertView : UIView


/**
 初始化alertView

 @param title 标题
 @param message 信息内容
 @param delegate 代理
 @param leftBtnTitle 左按钮标题
 @param rightBtnTitle 右按钮标题
 @return alertView
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle;

/**
 展示alertview
 */
- (void)showAlertView;

@property (nonatomic,assign) id<LLAlertViewDelegate> delegate;


// UI控件
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;

@end
