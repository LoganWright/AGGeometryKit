//
//  CALayer+LayoutChanges.m
//  AGGeometryKit
//
//  Created by Maria Fossli on 10.07.14.
//  Copyright (c) 2014 Håvard Fossli. All rights reserved.
//

#import "CALayer+LayoutChanges.h"
#import <JRSwizzle/JRSwizzle.h>
#import <objc/runtime.h>

@implementation CALayer (LayoutChanges)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        BOOL success = [self jr_swizzleMethod:@selector(layoutSublayers) withMethod:@selector(agk_layoutSublayers) error:&error];
        if(!success)
        {
            NSLog(@"Could not swizzle. This will cause -[CALayer layoutSublayersDueToBoundsChanges] to not work properly. Error %@", error);
        }
    });
}

static void * BoundsForLastLayoutKey = &BoundsForLastLayoutKey;

- (void)agk_layoutSublayers
{
    NSValue *boundsValueForLastLayout = objc_getAssociatedObject(self, BoundsForLastLayoutKey);
    
    BOOL trigger = YES;
    if(boundsValueForLastLayout != nil)
    {
        CGRect boundsForLastLayout = [boundsValueForLastLayout CGRectValue];
    }
    
    NSValue *currentBoundsValue = [NSValue valueWithCGRect:self.bounds];
    objc_setAssociatedObject(self, BoundsForLastLayoutKey, currentBoundsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self agk_layoutSublayers];
}

- (void)layoutSublayersDueToBoundsChanges
{
    
}

@end
