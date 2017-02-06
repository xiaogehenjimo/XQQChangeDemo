//
//  changeViewController.m
//  UItest
//
//  Created by XQQ on 16/8/10.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "changeViewController.h"



#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height
@interface changeViewController()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
/**
 * 自定制导航栏
 */
@property(nonatomic, strong)  UIView  *   centerView;
/**
 *  tabelView
 */
@property (nonatomic, strong) UITableView * myTabelView;
/**
 *  数据源
 */
@property (nonatomic, strong)  NSMutableArray  *  dataArr;
/**
 *  tabelView头视图
 */
@property (nonatomic, strong)  UIView  *  headView;
/**
 *  记录偏移量
 */
@property(nonatomic, assign)  CGPoint   tabelViewContentOffset;
/**
 *  titleView
 */
@property(nonatomic, strong)  UIImageView  *  titleView;

/**
 *  显示
 */
@property(nonatomic, assign)  BOOL   isShow;
/**
 *  不显示
 */
@property(nonatomic, assign)  BOOL   isHide;


@end

@implementation changeViewController

- (void)viewDidLoad
{;
    [super viewDidLoad];
    _isShow = NO;
    _isHide = YES;
   _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    _centerView.hidden = YES;
    self.navigationItem.titleView = _centerView;
    ;
   [_centerView addSubview:self.titleView];
    /**
     * 组织数据源
     */
    for (int i = 0; i < 20; i ++) {
        NSString * str = [NSString stringWithFormat:@"我是第%d行",i];
        [self.dataArr addObject:str];
    }
    [self.view addSubview:self.myTabelView];
    _tabelViewContentOffset = self.myTabelView.contentOffset;
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //记录初始的偏移量
  _tabelViewContentOffset = self.myTabelView.contentOffset;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //这里面拿到偏移量
    CGPoint size = self.myTabelView.contentOffset;
    NSLog(@"偏移量:%f",size.y);

    if (size.y > _tabelViewContentOffset.y) {
        //向上的
        if (_isShow ) {
            return;
        }
        if ( size.y > 35) {
            _isShow = YES;
            _isHide = NO;
            _centerView.hidden = NO;
            _titleView.hidden = NO;
            _titleView.frame = CGRectMake(_centerView.frame.size.width/2-20, -60, 40, 40);
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:5.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                
                _titleView.frame = CGRectMake(_centerView.frame.size.width/2-20, 0, 40, 40);
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
        _tabelViewContentOffset = size;
        
    }else
    {
        //向下的
        if (_isHide) {
            return;
        }
        if ( size.y < 35) {
            _isShow = NO;
            _isHide = YES;
            _titleView.hidden = NO;
            _titleView.frame = CGRectMake(_centerView.frame.size.width/2-20, 0, 40, 40);
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:5.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                
                _titleView.frame = CGRectMake(_centerView.frame.size.width/2-20, -60, 40, 40);
                
            } completion:^(BOOL finished) {
                
            }];
        }

        _tabelViewContentOffset = size;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * idStr = @"isStr";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - setter&getter

- (UIImageView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIImageView alloc]initWithFrame:CGRectMake(_centerView.frame.size.width/2-20, 0, 40, 40)];
        _titleView.layer.cornerRadius = 20;
        _titleView.layer.masksToBounds = YES;
        _titleView.backgroundColor = [UIColor orangeColor];
        _titleView.image = [UIImage imageNamed:@"0.jpg"];
        
    }
    return _titleView;
}
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iphoneWidth, 120)];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_headView.frame.size.width/2-40, 20, 80, 80)];
        
        imageView.layer.cornerRadius = 39.0;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [UIColor greenColor];
        imageView.image = [UIImage imageNamed:@"0.jpg"];
        [_headView addSubview:imageView];
    }
    return _headView;
}

- (UITableView *)myTabelView
{
    if (!_myTabelView) {
        _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, iphoneWidth,iphoneHeight) style:UITableViewStylePlain];
        _myTabelView.delegate = self;
        _myTabelView.dataSource = self;
        _myTabelView.tableHeaderView = self.headView;
        _myTabelView.clipsToBounds = YES;
    }
    return _myTabelView;
}


- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}



#pragma mark - customNavgationBar
- (void)customNavgationBar
{
    
    
    
}


@end
