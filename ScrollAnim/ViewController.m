//
//  ViewController.m
//  ScrollAnim
//
//  Created by Li Shuo on 13-11-14.
//  Copyright (c) 2013年 Li Shuo. All rights reserved.
//

#import "ViewController.h"
#import "ScrollAnim.h"
#import "ScrollAnimEntry.h"
#import "FVDeclareHelper.h"

@interface ViewController ()

@property (nonatomic, strong) ScrollAnim *anim;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.anim = [ScrollAnim.alloc init];

    UIScrollView *scrollView;
    UIImageView *imageView;
    UIView *skyView;

    FVDeclaration *declaration = [dec(@"root", self.view.bounds) $:@[
        dec(@"scrollView", CGRectMake(0, 0, FVP(1.f), FVP(1.f)), scrollView = ^{
            UIScrollView *scrollView = [UIScrollView.alloc init];
            scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
            scrollView.contentSize = CGSizeMake(500, 10000);
            return scrollView;
        }()),
        dec(@"sky", CGRectMake(0, 0, FVP(1.f), FVP(1.f)), skyView = ^{
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor colorWithRed:10/255.f green:91/255.f blue:146/255.f alpha:1.f];
            view.userInteractionEnabled = NO;
            return view;
        }()),
        dec(@"imageView", CGRectMake(0, 0, 200, 200), imageView = ^{
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sun_07.png"]];
            return imageView;
        }()),
    ]];
    [declaration setupViewTreeInto:self.view];
    [declaration updateViewFrame];

    [self.anim.animEntries addObjectsFromArray:@[
        [ScrollAnimEntry
            entryWithObject:imageView
       keyPathValueSequence:@[
                [KeyPathValueSequence
                    instanceWithKeyPath:@"center"
                              valueType:AnimEntryValuePoint
                           offsetValues:@[
                               MakeOV(100.f, [NSValue valueWithCGPoint:CGPointMake(100, 400)]),
                               MakeOV(200.f, [NSValue valueWithCGPoint:CGPointMake(200, 350)]),
                               MakeOV(300.f, [NSValue valueWithCGPoint:CGPointMake(300, 325)]),
                               MakeOV(400.f, [NSValue valueWithCGPoint:CGPointMake(400, 300)]),
                               MakeOV(500.f, [NSValue valueWithCGPoint:CGPointMake(500, 325)]),
                               MakeOV(600.f, [NSValue valueWithCGPoint:CGPointMake(600, 350)]),
                               MakeOV(700.f, [NSValue valueWithCGPoint:CGPointMake(700, 400)]),
                           ]]
            ]

        ],
        [ScrollAnimEntry
         entryWithObject:skyView keyPathValueSequence:@[
            [KeyPathValueSequence
             instanceWithKeyPath:@"backgroundColor"
             valueType:AnimEntryValueColor
             offsetValues:@[
                            MakeOV(100.f, [UIColor colorWithRed:10/255.f green:91/255.f blue:146/255.f alpha:1.f]),
                            MakeOV(400.f, [UIColor colorWithRed:112/255.f green:198/255.f blue:255/255.f alpha:1.f]),
                            MakeOV(700.f, [UIColor colorWithRed:255/255.f green:126/255.f blue:84/255.f alpha:1.f]),
                            ]]
            ]
         ]
    ]];
    
    self.anim.scrollView = scrollView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
