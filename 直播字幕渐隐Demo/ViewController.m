//
//  ViewController.m
//  直播字幕渐隐Demo
//
//  Created by xun on 2017/2/16.
//  Copyright © 2017年 xun. All rights reserved.
//

#import "ViewController.h"

//宽高
#define SCREEN_W ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_H ([[UIScreen mainScreen] bounds].size.height)
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define RGB(R/*红*/, G/*绿*/, B/*蓝*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:1]
#define labH 22
@interface ViewController ()<UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView *scroll;
    
    CGFloat lastOffsetY;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    scroll.contentSize   = CGSizeMake(SCREEN_W-32, 222);
    scroll.showsVerticalScrollIndicator = NO;
    scroll.scrollEnabled = NO;
    scroll.delegate = self;
    //scroll.contentOffset = CGPointMake(0, 222);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIBarButtonItem *rightI = [[UIBarButtonItem alloc] initWithTitle:@"弹一个" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightI;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)rightAction {
    lastOffsetY = scroll.contentOffset.y;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(1, 222 +lastOffsetY, 0, 0)];
    lab.text = @" 嘟嘟😀duoduo";
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = RGBA(10, 10, 10, 0.3);
    lab.alpha = 0;
    [scroll addSubview:lab];
    
    __weak typeof(lab) w_lab = lab;
    __weak typeof(scroll) w_scroll = scroll;
    [UIView animateWithDuration:0.15 animations:^{
        CGRect f = w_lab.frame;
        f.size.width = 200;
        f.size.height = labH;
        w_lab.frame = f;
        w_lab.alpha = 1;
        
        w_scroll.contentOffset = CGPointMake(scroll.contentOffset.x, scroll.contentOffset.y +labH+1);
    }];
    
    [UIView animateWithDuration:0.5 delay:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        w_lab.alpha = 0;
    } completion:^(BOOL finished) {
        [w_lab removeFromSuperview];
    }];
    NSLog(@"======%f", scroll.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


@end

