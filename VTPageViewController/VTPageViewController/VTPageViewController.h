//
//  VTPageViewController.h
//  VTPageViewController
//
//  Created by Vien Vu  on 1/20/16.
//  Copyright © 2016 VienVu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTPageViewController : UIViewController

/**
 *  Init
 *
 *  @param controllers List Controller
 *  @param titles      List title show to segment for each controller above
 *
 *  @return instance of Controller. Default background color of view is White;
 */
- (instancetype)initWithControllers:(NSArray *)controllers titleEachController:(NSArray *)titles;

/**
 *  Define height of Segment. Default Value is 50
 */
@property (assign, nonatomic) CGFloat heightSegment;


/**
 *  Define color of background Segment. Default is LightGray
 */
@property (strong, nonatomic) UIColor *colorBackgroundSegment;


/**
 *  Define height of indicator run below segment. Defaul is 5
 */
@property (assign, nonatomic) CGFloat heightIndicator;


/**
 *  color for background indicator. Default is LightGray
 */
@property (strong, nonatomic) UIColor *colorBackgroundIndicator;


/**
 *  color for background container indicator. Default is LightGray
 */
@property (strong, nonatomic) UIColor *colorBackgroundContainerIndicator;

/**
 *  Font for title on segment
 */
@property (strong, nonatomic) UIFont *fontTitle;


/**
 *  Default color of title segment. Default is Green.
 */
@property (strong, nonatomic) UIColor *colorTitleDefault;

/**
 *  Font size for Title. Default font size is 15
 */
@property (assign, nonatomic) CGFloat fontSizeTitle;


/**
 * Color of title segment when selected. Deafult is same with colorBackgroundIndicator.
 */
@property (strong, nonatomic) UIColor *colorTitleSegmentSelexted;

/**
 *  Define value have separate line bottom of indicator. Default is NO
 */
@property (assign, nonatomic) BOOL isHaveSeperateIndicator;

/**
 *  Allow user add custom View below segment. Default is nil
 */
@property (strong, nonatomic) UIView *customViewBelowSegment;

/**
 *  Define height for custom View. Default is 50 if customView added.
 */
@property (assign, nonatomic) CGFloat heightCustomView;


@end
