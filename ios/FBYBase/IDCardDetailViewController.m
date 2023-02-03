//
//  IDCardDetailViewController.m
//  FBYIDCardRecognition-iOS
//
//  Created by 范保莹 on 2017/12/29.
//  Copyright © 2017年 FBYIDCardRecognition-iOS. All rights reserved.
//

#import "IDCardDetailViewController.h"

#import "IDInfo.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface IDCardDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong,nonnull)NSArray *contentArr;
@property(strong,nonnull)NSArray *titleArr;
@property (strong, nonatomic) UIView *confirmView;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UITableView *infoTableView;

@end

@implementation IDCardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"身份证详细信息";
    
    NSLog(@"ctype====%c",_IDInfo.type);
    [self cardImage];
    
    [self setContentData];
    [self.view addSubview:self.infoTableView];
    [self createMessageLabel];
    [self createConfirmView];
}

- (void)cardImage {
    UIImageView *cardImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 85, SCREEN_WIDTH-20, SCREEN_HEIGHT/3)];
    cardImg.image = _IDImage;
    [self.view addSubview:cardImg];
}

- (void)setContentData {
    if(_IDInfo.num == NULL){
        
        _titleArr = @[@"签发机关：",@"有效期："];
        _contentArr = @[_IDInfo.issue,_IDInfo.valid];
        
    }else{
        
        _titleArr = @[@"姓名：",@"性别：",@"民族：",@"身份证号：",@"住址："];
        _contentArr = @[_IDInfo.name,_IDInfo.gender,_IDInfo.nation,_IDInfo.num,_IDInfo.address];
        
    }
    
    
//    for (int i = 0; i < _titleArr.count; i ++) {
//        int count = 30*i;
//
//        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/3+100+count, SCREEN_WIDTH/3, 30)];
//        titleLab.text = _titleArr[i];
//        [self.view addSubview:titleLab];
//
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/3+130+count, SCREEN_WIDTH-20, 1)];
//        lab.backgroundColor = [UIColor lightGrayColor];
//        [self.view addSubview:lab];
//
//        UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/3+100+count, SCREEN_WIDTH*2/3-30, 30)];
//        contentLab.numberOfLines = 0;
//        contentLab.text = _contentArr[i];
//        [self.view addSubview:contentLab];
//    }
}

- (UITableView *)infoTableView{
    if(_infoTableView == nil){
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT/3 + 100.f, SCREEN_WIDTH, SCREEN_HEIGHT - 100.f - SCREEN_HEIGHT/3 - 120) style:UITableViewStylePlain];
        _infoTableView.backgroundColor = [UIColor yellowColor];
        _infoTableView.dataSource = self;
        _infoTableView.delegate = self;
        _infoTableView.allowsSelection = false;
    }
    return _infoTableView;
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15.f, 0.f, SCREEN_WIDTH/3, 40)];
    [cell.contentView addSubview:titleLab];
    
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectZero];
    contentLab.numberOfLines = 0;
    [cell.contentView addSubview:contentLab];
    if(_IDInfo.num == NULL){
        contentLab.frame = CGRectMake(SCREEN_WIDTH/3 + 15.f, 0.f, SCREEN_WIDTH*2/3-30, 40);
    }else{
        if(indexPath.row == 4){
            contentLab.frame = CGRectMake(SCREEN_WIDTH/3 + 15.f, 0.f, SCREEN_WIDTH*2/3-30, 60);
        }else{
            contentLab.frame = CGRectMake(SCREEN_WIDTH/3 + 15.f, 0.f, SCREEN_WIDTH*2/3-30, 40);
        }
    }
    
    titleLab.text = _titleArr[indexPath.row];
    contentLab.text = _contentArr[indexPath.row];
    
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.f;
    if(_IDInfo.num == NULL){
        height = 40.f;
    }else{
        if(indexPath.row == 4){
            height = 60.f;
        }else{
            height = 40.f;
        }
    }
    return height;
}


- (void)createMessageLabel{
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT - 100.f, SCREEN_WIDTH, 30.f)];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = [UIColor redColor];
    self.messageLabel.font = [UIFont systemFontOfSize:15];
    self.messageLabel.text = @"请仔细核对身份证信息，确认无误";
    [self.view addSubview:self.messageLabel];
}


- (void)createConfirmView{
    self.confirmView = [[UIView alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT - 60.f, SCREEN_WIDTH, 60.f)];
    self.confirmView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.confirmView];
    
    UIButton *retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    retryBtn.frame = CGRectMake(15.f, 10.f, SCREEN_WIDTH / 2 - 25.f, 40.f);
    retryBtn.backgroundColor = [UIColor greenColor];
    [retryBtn setTitle:@"重新拍摄" forState:UIControlStateNormal];
    retryBtn.layer.cornerRadius = 8.f;
    [retryBtn addTarget:self action:@selector(retryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmView addSubview:retryBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(SCREEN_WIDTH / 2, 10.f, SCREEN_WIDTH / 2 - 25.f, 40.f);
    confirmBtn.backgroundColor = [UIColor greenColor];
    [confirmBtn setTitle:@"确    定" forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 8.f;
    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmView addSubview:confirmBtn];
}

- (void)retryAction:(id)sedner{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)confirmAction:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        NSDictionary *dic = @{
            @"idinfo" : self.IDInfo,
            @"idimage" : self.IDImage,
        };
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"confirmidinfosuccess" object:dic];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
