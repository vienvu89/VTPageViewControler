//
//  CommonAutolayoutUtils.h
//  Appster
//
//  Created by Vien Vu  on 1/8/16.
//  Copyright © 2016 Vien Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonAutolayoutUtils : NSObject

+ (void)addConstraintsChildToContainer:(UIView *) parent childView:(UIView *)child;
+ (void)addConstraintsChildToContainer:(UIView *) parent childView:(UIView *)child insets:(UIEdgeInsets)inset;

@end
