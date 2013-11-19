//
// Created by Li Shuo on 13-11-14.
// Copyright (c) 2013 Li Shuo. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface ScrollAnim : NSObject

@property (nonatomic, strong) NSMutableArray *animEntries;

-(void)setContentOffset:(float)contentOffset;
-(void)setScrollView:(UIScrollView*)scrollView;
@end
