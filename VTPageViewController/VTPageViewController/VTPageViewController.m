//
//  VTPageViewController.m
//  VTPageViewController
//
//  Created by Vien Vu  on 1/20/16.
//  Copyright © 2016 VienVu. All rights reserved.
//

#import "VTPageViewController.h"

@interface VTPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>


@property (strong, nonatomic) NSArray *pageContentControllers;
@property (strong, nonatomic) NSArray *listTitleButton;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) UIView *viewContainerButton;
@property (strong, nonatomic) NSMutableArray *listButton;

@property (strong, nonatomic) UIView *viewContainerIndicator;
@property (strong, nonatomic) UIView *viewIndicator;
@property (strong, nonatomic) NSLayoutConstraint *constraintLeadingIndicator;
@property (strong, nonatomic) UIView *viewseperate;

@property (assign, nonatomic) NSInteger currentIndexController;
@property (assign, nonatomic) NSInteger nextIndexController;
@property (assign, nonatomic) BOOL changedController;
@property (assign, nonatomic) BOOL isManuallSegmentSelect;
@property (assign, nonatomic) BOOL isGotoRighPlace;




@end

@implementation VTPageViewController


- (instancetype)initWithControllers:(NSArray *)controllers titleEachController:(NSArray *)titles {
    VTPageViewController *controller = [[VTPageViewController alloc] init];
    controller.listTitleButton = titles;
    controller.pageContentControllers = controllers;
    controller.heightSegment = 50;
    controller.isHaveSeperateIndicator = NO;
    controller.heightIndicator = 5;
    controller.colorBackgroundSegment = [UIColor lightGrayColor];
    controller.colorBackgroundIndicator = [UIColor blueColor];
    controller.colorBackgroundContainerIndicator = [UIColor lightGrayColor];
    controller.colorTitleDefault = [UIColor greenColor];
    controller.fontSizeTitle = 15;
    
    controller.heightCustomView = 50;
    
//    controller.color
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.listButton = [NSMutableArray array];
    [self setupButtonSegment];
    [self setupIndicator];
    [self setupSeperate];
    [self setupPageViewController];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    
}

- (void)setupButtonSegment {
    
    self.viewContainerButton  = [[UIView alloc] init];
    
    self.viewContainerButton.backgroundColor = self.colorBackgroundSegment;
    
    [self.view addSubview:self.viewContainerButton];
    NSDictionary *views =@{@"childView": self.viewContainerButton, @"container": self.view};
    self.viewContainerButton.translatesAutoresizingMaskIntoConstraints = NO;
    //Horizontal constraints
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childView]|" options:0 metrics:nil views:views];
    
    [self.view addConstraints:horizontalConstraints];
    //Vertical constraints
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[childView]" options:0 metrics:nil views:views];
    
    [self.viewContainerButton addConstraint:[NSLayoutConstraint constraintWithItem:self.viewContainerButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:self.heightSegment]];
    
    [self.view addConstraints:verticalConstraints];
    
    for (int i = 0; i < self.listTitleButton.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.viewContainerButton addSubview:button];
        [self.listButton addObject:button];
        
        if (!self.colorTitleSegmentSelexted) {
            self.colorTitleSegmentSelexted = self.colorBackgroundIndicator;
        }
        
        
        [button addTarget:self action:@selector(buttonAtIndexIsSelected:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        [button setTitleColor:self.colorTitleSegmentSelexted forState:UIControlStateSelected];
        [button setTitleColor:self.colorTitleDefault forState:UIControlStateNormal];
        if (self.fontTitle) {
            button.titleLabel.font = [self.fontTitle fontWithSize:self.fontSizeTitle];
        } else {
            button.titleLabel.font = [UIFont systemFontOfSize:self.fontSizeTitle];
        }
        
        
        [button setTitle:[self.listTitleButton objectAtIndex:i]  forState:UIControlStateNormal];
        button.showsTouchWhenHighlighted = NO;
        
        NSDictionary *views =@{@"childView": button, @"container": self.viewContainerButton};
        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[childView]|" options:0 metrics:nil views:views];
        [self.viewContainerButton addConstraints:horizontalConstraints];
        
        if (i != 0) {
           [self.viewContainerButton addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:((UIButton *)[self.listButton objectAtIndex:i - 1]) attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
            
            [self.viewContainerButton addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:(UIButton *)[self.listButton objectAtIndex:i -1] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
            
            if (i == self.listTitleButton.count - 1) {
                [self.viewContainerButton addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.viewContainerButton attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
            }
        } else {
            [button setSelected:YES];
            [self.viewContainerButton addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.viewContainerButton attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        }
    }
}

- (void)setupIndicator {
    
    self.viewContainerIndicator = [[UIView alloc] init];
    self.viewContainerIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.viewContainerIndicator];

    NSDictionary *views = @{@"childView": self.viewContainerIndicator, @"container": self.view, @"viewButton": self.viewContainerButton};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewButton]-0-[childView]" options:0 metrics:nil views:views]];
    
    [self.viewContainerIndicator addConstraint:[NSLayoutConstraint constraintWithItem:self.viewContainerIndicator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.heightIndicator]];
    
    self.viewContainerIndicator.backgroundColor = self.colorBackgroundContainerIndicator;
    

    self.viewIndicator = [[UIView alloc] init];
    self.viewIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.viewContainerIndicator addSubview:self.viewIndicator];
    
    [self.viewContainerIndicator addConstraint:[NSLayoutConstraint constraintWithItem:self.viewIndicator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.viewContainerIndicator attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    self.constraintLeadingIndicator = [NSLayoutConstraint constraintWithItem:self.viewIndicator attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.viewContainerIndicator attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    [self.viewContainerIndicator addConstraint:self.constraintLeadingIndicator];
    
    [self.viewIndicator addConstraint:[NSLayoutConstraint constraintWithItem:self.viewIndicator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.heightIndicator]];
    
    [self.viewIndicator addConstraint:[NSLayoutConstraint constraintWithItem:self.viewIndicator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.view.frame.size.width / self.listTitleButton.count]];
    
    self.viewIndicator.backgroundColor = self.colorBackgroundIndicator;
}


- (void)setupSeperate {
    if (!self.isHaveSeperateIndicator) {
        return;
    }
    self.viewseperate = [[UIView alloc] init];
    self.viewseperate.translatesAutoresizingMaskIntoConstraints = NO;
    [self.viewContainerIndicator addSubview:self.viewseperate];
    [self.viewContainerIndicator bringSubviewToFront:self.viewIndicator];
    
    NSDictionary *views =@{@"childView": self.viewseperate, @"container": self.viewContainerIndicator};
    [self.viewContainerIndicator addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childView]|" options:0 metrics:nil views:views]];
    
    [self.viewseperate addConstraint:[NSLayoutConstraint constraintWithItem:self.viewseperate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.0]];
    [self.viewContainerIndicator addConstraint:[NSLayoutConstraint constraintWithItem:self.viewseperate attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.viewIndicator attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    self.viewseperate.backgroundColor = [UIColor lightGrayColor];
}

- (void)setupPageViewController  {
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pageViewController setViewControllers:@[[self.pageContentControllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    });
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views =@{@"childView": self.pageViewController.view, @"container": self.view};
    //Horizontal constraints
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childView]|" options:0 metrics:nil views:views];
    
    [self.view addConstraints:horizontalConstraints];
    //Vertical constraints
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[childView]|" options:0 metrics:nil views:views];
    
    [self.view addConstraints:verticalConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageViewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.viewContainerIndicator attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];

    [self.pageViewController didMoveToParentViewController:self];
    
    for (UIView *subView  in self.pageViewController.view.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)subView).delegate = self;
        }
    }
}

#pragma mark - Button Action

- (void)buttonAtIndexIsSelected:(UIButton *)sender {
    if (self.currentIndexController == sender.tag) {
        return;
    }
    
    __unsafe_unretained typeof(self) weakSelf = self;
    UIViewController *controller = [self.pageContentControllers objectAtIndex:sender.tag];
    
    UIPageViewControllerNavigationDirection direction;
    if (sender.tag > self.currentIndexController) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }else{
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    self.isManuallSegmentSelect = YES;
    self.nextIndexController = sender.tag;
    
    
    NSArray *viewControllers = @[controller];
    [self.pageViewController setViewControllers:viewControllers direction:direction animated:YES completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.currentIndexController = weakSelf.nextIndexController;
            [weakSelf changeSelectedButtonToIndex:weakSelf.currentIndexController];
            weakSelf.isGotoRighPlace = NO;
            weakSelf.isManuallSegmentSelect = NO;
        });
        
    }];
}

#pragma mark - UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    for (NSInteger i = 0; i < self.pageContentControllers.count - 1; i++) {
        if (viewController == [self.pageContentControllers objectAtIndex:i]) {
            return [self.pageContentControllers objectAtIndex:i + 1];
        }
    }

    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    for (NSInteger i = self.pageContentControllers.count - 1; i > 0; i--) {
        if (viewController == [self.pageContentControllers objectAtIndex:i]) {
            
            return [self.pageContentControllers objectAtIndex:i - 1];
        }
    }

    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    if (pendingViewControllers.count > 0) {
        self.nextIndexController = [self checkIndexOfController:[pendingViewControllers firstObject]];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        if (self.nextIndexController != -1) {
            self.currentIndexController = self.nextIndexController;
        }
        self.changedController = YES;
    }
    if (finished) {

    }
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    
    float percentComplete;
    percentComplete = fabs(point.x - self.view.frame.size.width)/self.view.frame.size.width;
    
    if (self.isManuallSegmentSelect) {
        
        if (percentComplete == 1.0) {
            self.isGotoRighPlace = YES;
        }
        
        if (!self.isGotoRighPlace) {
            NSInteger changeIndex;
            if (self.nextIndexController > self.currentIndexController) {
                changeIndex = self.nextIndexController - self.currentIndexController;
            } else {
                changeIndex = self.currentIndexController - self.nextIndexController;
            }
            
            if (self.nextIndexController > self.currentIndexController || self.nextIndexController == self.pageContentControllers.count - 1) {
                self.constraintLeadingIndicator.constant = self.view.frame.size.width / self.pageContentControllers.count * percentComplete * changeIndex  + self.view.frame.size.width / self.pageContentControllers.count * self.currentIndexController;
            } else {
                self.constraintLeadingIndicator.constant = self.view.frame.size.width / self.pageContentControllers.count * self.currentIndexController - self.view.frame.size.width / self.pageContentControllers.count * percentComplete * changeIndex;
            }
        }
        
    } else {
        CGFloat widthSegment = self.view.frame.size.width / self.pageContentControllers.count;
        
        if (percentComplete * widthSegment > widthSegment / 2) {
            [self changeSelectedButtonToIndex:self.nextIndexController];
        }
        
        if (self.changedController) {
            self.constraintLeadingIndicator.constant = self.view.frame.size.width / self.pageContentControllers.count * self.currentIndexController;
            self.changedController = NO;
        } else  {
            if (self.nextIndexController > self.currentIndexController || self.nextIndexController == self.pageContentControllers.count - 1) {
                self.constraintLeadingIndicator.constant = self.view.frame.size.width / self.pageContentControllers.count * percentComplete + self.view.frame.size.width / self.pageContentControllers.count * self.currentIndexController;
            } else {
                self.constraintLeadingIndicator.constant = self.view.frame.size.width / self.pageContentControllers.count * self.currentIndexController - self.view.frame.size.width / self.pageContentControllers.count * percentComplete;
            }
        }
    }
}

#pragma mark - Utility

- (NSInteger)checkIndexOfController:(UIViewController *)controller  {
    for (NSInteger i = 0; i < self.pageContentControllers.count; i++) {
        if (controller == [self.pageContentControllers objectAtIndex:i]) {
            return i;
        }
    }
    
    return -1;
}

- (void)changeSelectedButtonToIndex:(NSInteger)index {
    for (UIButton *button in self.listButton) {
        if (button == [self.listButton objectAtIndex:index]) {
            [button setSelected:YES];
        } else {
            [button setSelected:NO];
        }
    }
}

@end
