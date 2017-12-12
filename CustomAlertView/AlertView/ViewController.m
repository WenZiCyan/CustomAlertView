//
//  ViewController.m
//  AlertView
//
//  Created by Fangjw on 2017/11/21.
//  Copyright © 2017年 Fangjw. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "CustomAlertView.h"

#define HEIGHTOFSCREEN [[UIScreen mainScreen] bounds].size.height
#define WIDTHOFSCREEN [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array=@[@"系统",@"单文字",@"多文字",@"默认textfield+btn",@"自定义textfield",@"自定义textfield+btn"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.textLabel.text=self.array[indexPath.row];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:{
                UIAlertController *ac=[UIAlertController alertControllerWithTitle:@"xxx" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder=@"--";
                    textField.clearButtonMode = UITextFieldViewModeAlways;
                }];
                [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:ac animated:true completion:nil];
        }
            break;
            
        case 1:{
            CustomAlertView *av=[[CustomAlertView alloc]initWithContentAndTitle:@"xxx" message:@"xxx\nxxx" content:@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" labelSetupHandler:^(UILabel * _Nonnull label) {
                
                label.textColor=[UIColor grayColor];
                label.textAlignment=NSTextAlignmentLeft;
                
            } buttonTitles:@[@"1",@"2"]];
            [av showView];
        }
            break;
            
        case 2:{
            CustomAlertView *av=[[CustomAlertView alloc]initWithContentsImgAndTitle:@"xx" message:@"xxxx" lContentTitles:@[@"111",@"222",@"333"] cContentTitles:@[@"aaa",@"aaa",@"aaa"] rContentTitles:@[@"444",@"555",@"666"] buttonTitles:nil];
//            av.backViewTapDismiss=YES;
            av.dismissBtnNeed=YES;
            av.dismissBtnImg=@"叉";
            [av showView];
            
        }
            break;
            
        case 3:{
            CustomAlertView *av=[[CustomAlertView alloc]initWithSendSecurityCodeAndTitle:nil message:@"xxxxxx" numberOfTextFields:2 textFieldsSetupHandler:^(UITextField * _Nonnull textField, NSUInteger index) {
                textField.placeholder = @"请输入";
            } buttonTitles:@[@"1",@"2"]];
            [av showView];
            
            av.horizontalBlock = ^(NSMutableDictionary * _Nullable dic, UIButton * _Nonnull btn) {};
            av.verticalBlock = ^(NSMutableDictionary * _Nullable dic, long integer) {};
        }
            break;
            
        case 4:{
            CustomAlertView *av=[[CustomAlertView alloc]initWithUserDefinedAlertView:@"xx" message:@"xxxx" numberOfControl:1 controlSetupHandler:^(UIView * _Nonnull view, NSUInteger index) {
                view.frame=CGRectMake(0, 0, WIDTHOFSCREEN, 80);
                UITextField *field=[UITextField new];
                field.placeholder=@"请输入";
                [view addSubview:field];
                [field mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view).offset(15);
                    make.right.equalTo(view).offset(-15);
                    make.bottom.equalTo(view.mas_bottom).offset(10);
                    make.top.equalTo(view.mas_top);
                }];
            } buttonTitles:@[@"1",@"2",@"3"]];
            av.backViewTapDismiss=YES;
            av.buttomBtnHorizontal=NO;
            [av showView];
            
            av.horizontalBlock = ^(NSMutableDictionary * _Nullable dic, UIButton * _Nonnull btn) {};
            av.verticalBlock = ^(NSMutableDictionary * _Nullable dic, long integer) {};
            
        }
            break;
            
        default:{
            CustomAlertView *av=[[CustomAlertView alloc]initWithUserDefinedAlertView:@"xx" message:@"xxx" numberOfControl:2 controlSetupHandler:^(UIView * _Nonnull view, NSUInteger index) {
                if (index==0) {
                    view.frame=CGRectMake(0, 0, WIDTHOFSCREEN, 60);
                    UITextField *field=[UITextField new];
                    field.placeholder=@"请输入";
                    [view addSubview:field];
                    [field mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(view).offset(15);
                        make.right.equalTo(view).offset(-150);
                        make.bottom.equalTo(view.mas_bottom).offset(10);
                        make.top.equalTo(view.mas_top);
                    }];
                    UIView *lineView=[UIView new];
                    lineView.backgroundColor=[UIColor lightGrayColor];
                    [view addSubview:lineView];
                    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(@1);
                        make.left.equalTo(view).offset(15);
                        make.right.equalTo(view).offset(-15);
                        make.top.equalTo(view.mas_top).offset(50);
                    }];
                }
                if (index==1){
                    view.frame=CGRectMake(0, 0, WIDTHOFSCREEN, 60);
                    UIButton *button=[UIButton new];
                    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                    [button setBackgroundColor:[UIColor blackColor]];
                    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                    button.titleLabel.font = [UIFont systemFontOfSize:14];
                    [view addSubview:button];
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(view).offset(15);
                        make.right.equalTo(view).offset(-15);
                        make.bottom.equalTo(view.mas_bottom).offset(-10);
                        make.top.equalTo(view.mas_top);
                    }];
                }
            } buttonTitles:@[@"1",@"2"]];
            [av showView];
            
            av.horizontalBlock = ^(NSMutableDictionary * _Nullable dic, UIButton * _Nonnull btn) {};
            av.verticalBlock = ^(NSMutableDictionary * _Nullable dic, long integer) {};
            av.otherBlock = ^(NSMutableDictionary * _Nullable dic, UIButton * _Nonnull btn) {};
        }
            break;
    }
}

@end
