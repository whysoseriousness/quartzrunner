//
//  GameView.h
//  QuartzRunner
//
//  Created by Elevation Recording  on 1/17/13.
//  Copyright (c) 2013 integritas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView <UIAccelerometerDelegate>{
    CGRect viewableMapArea;
    CGPoint boxCenter;
    float tileWidth;
    float tileHeight;
    NSMutableArray * boxes;
    NSMutableArray * bullets;
    NSTimer * mainGameTimer;
    
}

-(void) loadLevel: (NSString*) levelReference;
@end
