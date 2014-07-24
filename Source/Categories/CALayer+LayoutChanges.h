//
//  CALayer+LayoutChanges.h
//  AGGeometryKit
//
//  Created by Maria Fossli on 10.07.14.
//  Copyright (c) 2014 Håvard Fossli. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (LayoutChanges)

- (void)layoutSublayersDueToBoundsChanges;

@end
