# VTPageViewControler
=============

A simple pageViewcontroller have same behavior with Instagrame notification tab.


![Alt text](https://i.gyazo.com/5c1c3b0fbe9a4a4e79650ab3a88e2e76.gif "Demo")

Usage
==============


```objc
#import "VTPageViewController.h"
.
.
.


//Creat List Controller
//Create List title match with each controller above

self.controller = [[VTPageViewController alloc] initWithControllers:ListController titleEachController:List Title];

//Cusomize for attirubte you want

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

## Licence

MIT