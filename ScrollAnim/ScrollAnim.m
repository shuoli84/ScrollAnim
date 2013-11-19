//
// Created by Li Shuo on 13-11-14.
// Copyright (c) 2013 Li Shuo. All rights reserved.
//


#import <Glue/Binding.h>
#import "ScrollAnim.h"
#import "ScrollAnimEntry.h"


@interface ScrollAnim()

@property (nonatomic, strong) Binding *scrollViewBinding;

@end

@implementation ScrollAnim {
    UIScrollView *_scrollView;
}

-(id)init{
    if((self = super.init)){
        self.animEntries = [NSMutableArray array];
    }
    return self;
}

-(void)setContentOffset:(float)contentOffset{
    for(ScrollAnimEntry *entry in _animEntries){
        [entry setContentOffset:contentOffset];
    }
}

-(void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    typeof(self) __weak weakSelf = self;

    _scrollViewBinding = binding(scrollView, @"contentOffset", ^(NSObject *object) {
        CGPoint offset = [(NSValue*)object CGPointValue];
        [weakSelf setContentOffset:offset.y];
    });
}

@end