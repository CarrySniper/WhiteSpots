//
//  ViewController.m
//  WhiteSpots白点
//
//  Created by 陈家庆 on 15-2-6.
//  Copyright (c) 2015年 shikee_Chan. All rights reserved.
//

#import "ViewController.h"

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define fNavBarHeigth (IOS7==YES ? 64 : 44)

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    UIButton *whiteSpotsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    whiteSpotsButton.frame = CGRectMake(10, 100, 44, 44);
    whiteSpotsButton.backgroundColor = [UIColor whiteColor];
    whiteSpotsButton.layer.cornerRadius = 22;
    [whiteSpotsButton setTitle:@"白点" forState:UIControlStateNormal];
    [whiteSpotsButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [whiteSpotsButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:whiteSpotsButton];
    
    //拖动的 UIPanGestureRecognizer
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [self.view bringSubviewToFront:whiteSpotsButton];//放到最前面
    [whiteSpotsButton addGestureRecognizer:panRecognizer];//关键语句，添加一个手势监测；
    panRecognizer.maximumNumberOfTouches = 1;
    panRecognizer.delegate = self;
    
}
#pragma mark- 按钮点击
- (void)btnClick:(UIButton *)sender{
    NSLog(@"白点被点击");
}
-(void)handlePanFrom:(UIPanGestureRecognizer*)recognizer
{
    NSLog(@"拖动操作");
    //处理拖动操作,拖动是基于imageview，如果经过旋转，拖动方向也是相对imageview上下左右移动，而不是屏幕对上下左右
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    NSLog(@"%f %f",recognizer.view.center.y+translation.y,fDeviceHeight-49);
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    if(recognizer.state == UIGestureRecognizerStateEnded){
        if (recognizer.view.center.x + translation.x<fDeviceWidth/2) {
            [UIView animateWithDuration:0.5f animations:^{
                recognizer.view.center = CGPointMake(recognizer.view.frame.size.width/2, recognizer.view.center.y + translation.y);
            }];
        }else{
            [UIView animateWithDuration:0.5f animations:^{
                recognizer.view.center = CGPointMake(fDeviceWidth-recognizer.view.frame.size.width/2, recognizer.view.center.y + translation.y);
            }];
        }
        if (recognizer.view.center.y+translation.y<recognizer.view.frame.size.width/2 || recognizer.view.center.y+translation.y>fDeviceHeight-fNavBarHeigth-recognizer.view.frame.size.width/2-49) {
            [UIView animateWithDuration:0.5f animations:^{
                recognizer.view.center = CGPointMake(fDeviceWidth-44/2-5, fDeviceHeight-fNavBarHeigth-100+44/2);
            }];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
