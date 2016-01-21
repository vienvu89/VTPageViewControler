//
//  CommonAutolayoutUtils.m
//  Appster
//
//  Created by Vien Vu  on 1/8/16.
//  Copyright © 2016 Vien Vu. All rights reserved.
//

#import "CommonAutolayoutUtils.h"

@implementation CommonAutolayoutUtils


+ (void)addConstraintsChildToContainer:(UIView *)parent childView:(UIView *)child {
    [parent addSubview:child];
    child.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views =@{@"childView": child,@"container": parent};
    //Horizontal constraints
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childView]|" options:0 metrics:nil views:views];
    
    [parent addConstraints:horizontalConstraints];
    //Vertical constraints
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[childView]|" options:0 metrics:nil views:views];
    
    [parent addConstraints:verticalConstraints];
}

+ (void)addConstraintsChildToContainer:(UIView *)parent childView:(UIView *)child insets:(UIEdgeInsets)inset {
    [parent addSubview:child];
    child.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views =@{@"childView": child,@"container": parent};
    //Horizontal constraints
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[childView]-%f-|", inset.left, inset.right] options:0 metrics:nil views:views];
    
    [parent addConstraints:horizontalConstraints];
    //Vertical constraints
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[childView]-%f-|", inset.top, inset.bottom] options:0 metrics:nil views:views];
    
    [parent addConstraints:verticalConstraints];
}

@end
