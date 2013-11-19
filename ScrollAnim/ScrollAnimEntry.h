//
// Created by Li Shuo on 13-11-14.
// Copyright (c) 2013 Li Shuo. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef NS_ENUM( NSInteger, AnimEntryValueType){
    AnimEntryValueFloat,
    AnimEntryValueColor,
    AnimEntryValuePoint,
    AnimEntryValueRect,
    AnimEntryValueSize,
    AnimEntryValueAffineTransform,
    AnimEntryValue3DTransform,
};

@interface OffsetValue : NSObject

@property (nonatomic, assign) float offset;
@property (nonatomic, strong) NSObject *value;

+(OffsetValue*)instanceWithOffset:(float)offset value:(NSObject*)value;
@end

OffsetValue* MakeOV(float offset, NSObject* value);

@interface KeyPathValueSequence : NSObject
@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic, assign) AnimEntryValueType valueType;
@property (nonatomic, strong) NSMutableArray *offsetValues;

+(KeyPathValueSequence *)instanceWithKeyPath:(NSString*)keyPath
                                   valueType:(AnimEntryValueType)valueType
                                offsetValues:(NSArray*)offsetValues;

-(NSObject *)valueForContentOffset:(float)contentOffset;

@end

@interface ScrollAnimEntry : NSObject

@property (nonatomic, strong) NSObject *object;
@property (nonatomic, strong) NSMutableArray *keyPathValueSequences;

+(ScrollAnimEntry*)entryWithObject:(NSObject*)object
              keyPathValueSequence:(NSArray*)offsetValueArray;
-(void)setContentOffset:(float)contentOffset;

@end