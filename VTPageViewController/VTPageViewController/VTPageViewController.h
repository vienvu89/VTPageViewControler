//
//  VTPageViewController.h
//  VTPageViewController
//
//  Created by Vien Vu  on 1/20/16.
//  Copyright © 2016 VienVu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTPageViewController : UIViewController

@property (strong, nonatomic) NSArray *pageContentControllers;
@property (assign, nonatomic) CGFloat heightButton;
@property (assign, nonatomic) CGFloat heightIndicator;
@property (strong, nonatomic) NSArray *listTitleButton;
@property (strong, nonatomic) UIColor *colorBackgroundIndicator;
@property (strong, nonatomic) UIColor *colorTitleSegmentSelexted;

@end
