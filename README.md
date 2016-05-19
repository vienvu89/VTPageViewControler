# VTPageViewControler

[![Build Status](https://travis-ci.org/vienvu89/VTPageViewControler.svg?branch=master)](https://travis-ci.org/vienvu89/VTPageViewControler)

A simple pageViewcontroller has same behavior like Instagram notification tab.

![Alt text](https://i.gyazo.com/58fec8fee99b97c5bb55419ba99c24ad.gif "Demo")

#Usage


Clone project and drag two files:

    VTPageViewController.h
    VTPageViewController.m 

to your project.


```objc
#import "VTPageViewController.h"
.
.
.


//Creat List Controller
//Create List title match with each controller above

self.controller = [[VTPageViewController alloc] initWithControllers:ListController titleEachController:List Title];

//Cusomize for attribute you want

_controller.colorBackgroundIndicator = [UIColor yellowColor];
_controller.heightSegment  = 50;
_controller.heightIndicator = 5;
_controller.fontTitle = [UIFont fontWithName:@"Futura-CondensedMedium" size:15];
_controller.fontSizeTitle = 13;

//Add to parent view
[self addChildViewController:_controller];
[self.view addSubview:_controller.view];
[_controller didMoveToParentViewController:self];

```

More attributes for custom see in VTPageViewController.h file.

## Licence

MIT
