//
//  LRWDrageViewController.m
//  LRWDrageViewDemo
//
//  Created by rwli on 16/11/18.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWDrageViewController.h"
#import "objcBlockbyLRW.h"

@interface LRWDrageViewController ()


@end

@implementation LRWDrageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

-(void)setupUI{
    UIColor *red =kRedColor;
    UIColor *green =kGreenColor;
    UIColor *blue =kBlueColor;
    NSArray *colorArry =[NSArray arrayWithObjects:red,green,blue, nil];
    for (int i=0; i<3; i++) {
        UIView *view =[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor =colorArry[i];
        [self.view insertSubview:view atIndex:i];
        switch (i) {
            case 0:
                self.leftV=view;
                break;
            case 1:
                self.rightV=view;
                break;
            case 2:
                self.midleV=view;
                break;
            default:
                break;
        }
    }
    
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panClick:)];
    [self.midleV addGestureRecognizer:pan];
    
    //增加点按收手势会到初始位置
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];

}
-(void)tapClick{
    self.midleV.frame =self.view.bounds;
}

-(void)panClick:(UIPanGestureRecognizer*)sender{
    //move view
    CGPoint point =[sender translationInView:self.view];
       self.midleV.frame=[self framWithoffset_x:point.x];
    [sender setTranslation:CGPointZero inView:self.midleV];
    
    //手势结束自动移动
    if (sender.state ==UIGestureRecognizerStateEnded) {
    #define off_x self.midleV.frame.origin.x
        if (off_x>kScreenWidth*0.5) {
            self.midleV.frame =[self framWithoffset_x:kScreenWidth*0.8-off_x];
        }else if(off_x<-kScreenWidth*0.5){
            self.midleV.frame=[self framWithoffset_x:-kScreenWidth*0.8-off_x];
        }else{
            self.midleV.frame=self.view.bounds;
        }
    }
    
}

-(CGRect)framWithoffset_x:(CGFloat)x{
    CGRect frame =self.midleV.frame;
    if (frame.origin.x>0) {
        self.rightV.hidden =YES;
    }else if(frame.origin.x<0){
        self.rightV.hidden=NO;
    }

    frame.origin.x +=x;
    frame.origin.y= fabs(frame.origin.x/kScreenWidth*kScreenHeight*0.2);
    frame.size.height= kScreenHeight -2*frame.origin.y;
    return frame;
}








@end
