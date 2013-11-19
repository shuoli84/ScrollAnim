//
// Created by Li Shuo on 13-11-14.
// Copyright (c) 2013 Li Shuo. All rights reserved.
//


#import "ScrollAnimEntry.h"

@implementation OffsetValue

+(OffsetValue*)instanceWithOffset:(float)offset value:(NSObject*)value{
    OffsetValue *offsetValue = [OffsetValue.alloc init];

    offsetValue.offset = offset;
    offsetValue.value = value;

    return offsetValue;
}
@end

OffsetValue* MakeOV(float offset, NSObject* value){
    return [OffsetValue instanceWithOffset:offset value:value];
}

@implementation KeyPathValueSequence

+(KeyPathValueSequence *)instanceWithKeyPath:(NSString*)keyPath
                                   valueType:(AnimEntryValueType)valueType
                                offsetValues:(NSArray*)offsetValues{
    KeyPathValueSequence *instance = [KeyPathValueSequence.alloc init];
    instance.keyPath = keyPath;
    instance.valueType = valueType;
    instance.offsetValues = offsetValues.mutableCopy;
    return instance;
}

-(NSObject *)valueForContentOffset:(float)contentOffset{
    OffsetValue *start = nil;
    OffsetValue *end = nil;
    for(OffsetValue *offsetValue in self.offsetValues){
        if(offsetValue.offset >= contentOffset){
            end = offsetValue;
            break;
        }
        else{
            start = offsetValue;
        }
    }
    
    if(start == nil || contentOffset == end.offset){
        return end.value;
    }
    if(end == nil || contentOffset == start.offset){
        return start.value;
    }
    
    float ratio = (contentOffset - start.offset) / (end.offset - start.offset);
    ratio = ratio > 1 ? 1 : (ratio < 0 ? 0 : ratio);
    
    NSObject *fromValue = start.value;
    NSObject *toValue = end.value;
    
    switch (self.valueType) {
        case AnimEntryValueFloat:{
            float from = [(NSNumber *) fromValue floatValue];
            float to = [(NSNumber *) toValue floatValue];
            return @(from + (to - from) * ratio);
        }
        case AnimEntryValueColor:{
            UIColor *from = (UIColor*)fromValue;
            float fred, fgreen, fblue, falpha;
            UIColor *to = (UIColor*)toValue;
            float tred, tgreen, tblue, talpha;
            
            [from getRed:&fred green:&fgreen blue:&fblue alpha:&falpha];
            [to getRed:&tred green:&tgreen blue:&tblue alpha:&talpha];
            
            return [UIColor colorWithRed:fred + (tred - fred) * ratio green:fgreen + (tgreen - fgreen)*ratio blue:fblue + (tblue - fblue)*ratio alpha:falpha + (talpha - falpha)*ratio];
        }
        case AnimEntryValueRect:{
            CGRect from = [(NSValue *) fromValue CGRectValue];
            CGRect to = [(NSValue *) toValue CGRectValue];
            return [NSValue valueWithCGRect:CGRectMake(from.origin.x + (to.origin.x - from.origin.x)*ratio,
                                                       from.origin.y + (to.origin.y - from.origin.y)*ratio,
                                                       from.size.width + (to.size.width - from.size.width)*ratio,
                                                       from.size.height + (to.size.height - from.size.height)*ratio
                                                       )];
        }
        case AnimEntryValuePoint:{
            CGPoint from = [(NSValue *) fromValue CGPointValue];
            CGPoint to = [(NSValue *) toValue CGPointValue];
            return [NSValue valueWithCGPoint:CGPointMake(from.x + (to.x - from.x) * ratio, from.y + (to.y - from.y) * ratio)];
        }
        case AnimEntryValueAffineTransform:{
            CGAffineTransform from = [(NSValue*) fromValue CGAffineTransformValue];
            CGAffineTransform to = [(NSValue*) toValue CGAffineTransformValue];
            CGAffineTransform result = CGAffineTransformMake(
                                                             from.a + (to.a - from.a)*ratio,
                                                             from.b + (to.b - from.b)*ratio,
                                                             from.c + (to.c - from.c)*ratio,
                                                             from.d + (to.d - from.d)*ratio,
                                                             from.tx + (to.tx - from.tx)*ratio,
                                                             from.ty + (to.ty - from.ty)*ratio);
            return [NSValue valueWithCGAffineTransform:result];
        }
        default:{
            return nil;
        }
    }
}

@end

@implementation ScrollAnimEntry {
}

+(ScrollAnimEntry*)entryWithObject:(NSObject*)object
              keyPathValueSequence:(NSArray*)offsetValueArray{
    ScrollAnimEntry *animEntry = [[ScrollAnimEntry alloc] init];
    animEntry.object = object;
    animEntry.keyPathValueSequences = offsetValueArray.mutableCopy;
    return animEntry;
}

-(void)setContentOffset:(float)contentOffset{
    for (KeyPathValueSequence* keyPathValueSequence in self.keyPathValueSequences){
        NSObject* v = [keyPathValueSequence valueForContentOffset:contentOffset];
        if(v != nil){
            [_object setValue:v forKey:keyPathValueSequence.keyPath];
        }
    }
    
}
@end