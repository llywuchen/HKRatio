//
//  ViewController.m
//  HKRatio
//
//  Created by heke on 14/3/16.
//  Copyright © 2016年 mhk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *baColorLayer;
@property (nonatomic, strong) CAShapeLayer *frontMask;
@property (nonatomic, strong) CAShapeLayer *backMask;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baColorLayer = [CALayer layer];
    self.baColorLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.baColorLayer.frame = CGRectMake(10, 74, 300, 20);
    [self.view.layer addSublayer:self.baColorLayer];
    
    CAShapeLayer *backMask = [CAShapeLayer new];
    backMask.frame = CGRectMake(0, 0, 100, 20);
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 20) cornerRadius:4];
    backMask.path = bPath.CGPath;
    backMask.fillColor = [UIColor greenColor].CGColor;
    [self.baColorLayer addSublayer:backMask];
    self.backMask = backMask;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 20)];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"[[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 20)];";
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 20)];
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"[[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 20)];";
    [self.view addSubview:label];
    
    CAShapeLayer *frontMask = [CAShapeLayer layer];
    frontMask.frame = CGRectMake(0, 0, 100, 20);
    bPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 20)];
    frontMask.path = bPath.CGPath;
    label.layer.mask = frontMask;
    self.frontMask = frontMask;
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 110, self.view.bounds.size.width-40, 40)];
    slider.maximumValue = 300;
    slider.minimumValue = 0;
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)valueChanged:(UISlider *)slider {
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0];
    
    CGRect rt = self.frontMask.frame;
    rt.origin.x = slider.value;
    [self.frontMask setFrame:rt];
    
    rt = self.backMask.frame;
    rt.origin.x = slider.value;
    CGFloat delta = 300-rt.origin.x;
    if (delta<100) {
        self.backMask.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, delta, 20) cornerRadius:4].CGPath;
    }else{
        self.backMask.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 20) cornerRadius:4].CGPath;
    }
    
    [self.backMask setFrame:rt];
    
    [CATransaction commit];
}


@end
