//
//  Box.m
//  QuartzRunner
//
//  Created by Elevation Recording  on 1/18/13.
//  Copyright (c) 2013 integritas. All rights reserved.
//

#import "Box.h"

@implementation Box

- (id) initWithFrame: (CGRect) frame{
   self =  [super init];
    if(self){
        self.frame = frame;
    }
    return self;
}

@end
