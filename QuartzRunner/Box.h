//
//  Box.h
//  QuartzRunner
//
//  Created by Elevation Recording  on 1/18/13.
//  Copyright (c) 2013 integritas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Box : NSObject

@property (nonatomic) CGRect frame;
@property (nonatomic) CGRect RGBAFillColor;
@property (nonatomic) CGRect RGBAStrokeColor;

- (id) initWithFrame: (CGRect) frame;

@end
