//
//  ViewController.m
//  VTPageViewController
//
//  Created by Vien Vu  on 1/19/16.
//  Copyright © 2016 VienVu. All rights reserved.
//

#import "ViewController.h"
#import "CommonAutolayoutUtils.h"
#import "ViewControllerForScroll.h"
#import "VTPageViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewContainerPageViewController;
@property (strong, nonatomic) VTPageViewController *controller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    [self setupPageViewController];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupPageViewController  {
    ViewControllerForScroll *controller1 = [[ViewControllerForScroll alloc] init];
    controller1.view.backgroundColor = [UIColor orangeColor];
    ViewControllerForScroll *controller2 = [[ViewControllerForScroll alloc] init];
    controller2.view.backgroundColor = [UIColor purpleColor];
    ViewControllerForScroll *controller3 = [[ViewControllerForScroll alloc] init];
    controller3.view.backgroundColor = [UIColor greenColor];
    
    ViewControllerForScroll *controller4 = [[ViewControllerForScroll alloc] init];
    controller4.view.backgroundColor = [UIColor grayColor];
    
    self.controller = [[VTPageViewController alloc] initWithControllers:@[controller1, controller2, controller3, controller4] titleEachController:@[@"abc", @"def", @"zxc", @"cvnbn"]];
    _controller.colorBackgroundIndicator = [UIColor yellowColor];
    _controller.heightSegment  = 50;
    _controller.heightIndicator = 5;
    _controller.fontTitle = [UIFont fontWithName:@"Futura-CondensedMedium" size:15];
    _controller.fontSizeTitle = 13;

    [CommonAutolayoutUtils addConstraintsChildToContainer:self.viewContainerPageViewController childView:_controller.view];
    [_controller didMoveToParentViewController:self];
}



@end
