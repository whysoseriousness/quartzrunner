//
//  GameView.m
//  QuartzRunner
//
//  Created by Elevation Recording  on 1/17/13.
//  Copyright (c) 2013 integritas. All rights reserved.
//

#import "GameView.h"
#import "Box.h"

@implementation GameView
CFTimeInterval lastTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        viewableMapArea = CGRectMake(0.0, 0.0, 32.0, 48.0);
        tileWidth = 10.0f;
        tileHeight = 10.0f;
        boxCenter = CGPointMake(160.0, 60.0);
        boxes = [[NSMutableArray alloc] init];
        bullets = [[NSMutableArray alloc] init];
        mainGameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(mainGameLoop) userInfo:nil repeats:YES];
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        [self loadLevel: @"template2"];
        
    }
    return self;
}

-(void) loadLevel: (NSString*) levelReference{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:levelReference ofType:@""];
    NSString *levelData = [NSString stringWithContentsOfFile:filePath encoding:NSStringEncodingConversionExternalRepresentation error:nil];
    int x = 0;
    int y = 0;
    for(int k = 0; k < [levelData length]; k++){
        char c =[levelData characterAtIndex:k];
        if (c == '\n' ) {
            [boxes addObject:[NSMutableArray array]];
            y++;
            x = 0;
       }
        if(c=='+'){
            Box *tmpBox = [[Box alloc] initWithFrame:CGRectMake(x*10.0, y*10.0, 10.0, 10.0)];
            [[boxes lastObject] addObject:tmpBox];
        }
        x++;
    }
    NSLog([NSString stringWithFormat:@"%@: \n%@ \n\n %@", levelReference, levelData, boxes]);
    
}

-(void) mainGameLoop{
    CFTimeInterval time = CFAbsoluteTimeGetCurrent();
    float delta = time - lastTime;
    delta /= 1000000000;
    viewableMapArea.origin.y += delta/2;
    if (viewableMapArea.origin.y  > [boxes count] ) {
        viewableMapArea.origin.y = 0.0;
    }
   // NSLog([NSString stringWithFormat:@"%f",delta]);
//    for(NSMutableArray *tmp in boxes){
//        for(Box *box in tmp){
//            box.frame = CGRectMake(box.frame.origin.x, box.frame.origin.y - delta, box.frame.size.width, box.frame.size.height);
//        }
//    }
    int bulletEnd = [bullets count];
    for(int bulletCounter = 0; bulletCounter < bulletEnd; bulletCounter++){
        Box* bullet = [bullets objectAtIndex:bulletCounter];
        float y = bullet.frame.origin.y + 3*delta;
        if ( y > 480.0 ){
            [bullets removeObjectAtIndex:bulletCounter];
            bulletCounter--;
            bulletEnd--;
        }
        bullet.frame = CGRectMake(bullet.frame.origin.x, y, bullet.frame.size.width, bullet.frame.size.height);
    }
    [self setNeedsDisplay];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
       if (boxCenter.x < -40.0) {
            boxCenter.x = 360.0;
        }else if( boxCenter.x > 360.0){
            boxCenter.x = -40.0;
        }
   boxCenter.x -= acceleration.y*20.0;
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch =  [[[event allTouches] allObjects] objectAtIndex:0];
//    if (CGRectContainsPoint(CGRectMake(boxCenter.x-80.0, boxCenter.y-80.0, 160.0, 160.0), [touch locationInView:self])) {
//        boxCenter = [touch locationInView:self];
//    }
//        [boxes addObject:[[Box alloc] initWithFrame: CGRectMake(0.0, 0.0, arc4random()%120, arc4random()%50)]];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    if([mainGameTimer isValid]){
//        [mainGameTimer invalidate];
//    }else{
//        mainGameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(mainGameLoop) userInfo:nil repeats:YES];
//    }
    Box * bullet = [[Box alloc] initWithFrame:CGRectMake(boxCenter.x, boxCenter.y, 10.0, 30.0)];
    [bullets addObject:bullet];
    NSLog(@"\n%f, %f", [[bullets lastObject] frame].origin.x, [[bullets lastObject] frame].origin.x);
    
}

-(void) drawRect: (CGRect ) rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextClearRect(context, self.frame);
    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetShouldAntialias(context, NO);
    CGContextSetShouldSmoothFonts(context, NO);
    
    
    for(int k = 0; k < ceil(viewableMapArea.size.height); k++){
        int x = k + viewableMapArea.origin.y;
        if (x > [boxes count] - 1){
            x -= [boxes count];
        }
        int end = [[boxes objectAtIndex:x] count];
        for(int counter = 0; counter < end; counter++ ){
            Box * box = [[boxes objectAtIndex:x] objectAtIndex:counter];
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 1.0, 1.0);
            CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextSetLineWidth(context, 2.0);
        //    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
            //    CGContextMoveToPoint(context, 0.0f, 0.0f);
//            CGRect tmpFrame = CGRectMake(box.frame.origin.x-viewableMapArea.origin.x*tileWidth, box.frame.origin.y -viewableMapArea.origin.y*tileHeight, box.frame.size.width, box.frame.size.height);
            CGRect tmpFrame = CGRectMake(box.frame.origin.x-viewableMapArea.origin.x*tileWidth, k*tileHeight, box.frame.size.width, box.frame.size.height);
            if(CGRectIntersectsRect(tmpFrame, CGRectMake(boxCenter.x-40.0, boxCenter.y-40.0, 80.0, 80.0))){
                //   NSLog(@"D:" );
            }
            
            int bulletEnd = [bullets count];
            for(int bulletCounter = 0; bulletCounter < bulletEnd; bulletCounter++){
                Box * bullet = [bullets objectAtIndex:bulletCounter];
                if(CGRectIntersectsRect(bullet.frame, tmpFrame)){
                    //   NSLog(@"D:" );
                    [[boxes objectAtIndex:x] removeObjectAtIndex:counter];
                    [bullets removeObjectAtIndex: bulletCounter];
                    bulletCounter--;
                    bulletEnd--;
                    counter--;
                    end--;
                }
            }
            CGContextStrokeRect(context, tmpFrame);
            CGContextFillRect(context, tmpFrame);
            
//            if (CGRectIntersectsRect(box.frame, CGRectMake(boxCenter.x-40.0, boxCenter.y-40.0, 80.0, 80.0))) {
//                NSLog(@":C");
//            }
        }
    }
    
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 20.0);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextMoveToPoint(context, 0.0f, 0.0f);

    CGContextStrokeEllipseInRect(context, CGRectMake(boxCenter.x-10.0, boxCenter.y-10.0, 20.0, 20.0));
    CGContextFillEllipseInRect(context, CGRectMake(boxCenter.x-10.0, boxCenter.y-10.0, 20.0, 20.0));
    CGContextStrokePath(context);

   
    
    for(Box * bullet in bullets){
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
        CGContextFillRect(context, bullet.frame);
    }
    
    CGContextRestoreGState(context);
}


@end
