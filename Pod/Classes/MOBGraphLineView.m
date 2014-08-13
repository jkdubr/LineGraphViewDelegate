//
//  MOBGraphLineView.m
//  MyGraph
//
//  Created by Jakub Dubrovsky on 11/05/14.
//  Copyright (c) 2014 Mobera. All rights reserved.
//

#import "MOBGraphLineView.h"


@implementation MOBGraphLineView

#define kGraphPadding 10


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
 
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat xMax=0.0;
    CGFloat yMax=0.0;
    CGFloat xMin=0.0;
    CGFloat yMin=0.0;
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:[self.delegate mobGraphLineNumberOfItems:self]];
    
    for (NSUInteger i = 0; i<[self.delegate mobGraphLineNumberOfItems:self]; i++) {
        id<MOBGraphPointDelegate> obj = [self.delegate mobGraph:self pointAtPosition:i];
        xMax = MAX(xMax, [obj mobGraphPointX]);
        yMax = MAX(yMax, [obj mobGraphPointY]);
        xMin = xMin==0 ? [obj mobGraphPointX] : MIN(xMin, [obj mobGraphPointX]);
        yMin = yMin==0 ? [obj mobGraphPointY] : MIN(yMin, [obj mobGraphPointY]);
        [data addObject:obj];
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGColorRef color = [[self.delegate mobGraphColor:self] CGColor];
    
    CGContextSetLineWidth(ctx, 4);
    CGContextSetStrokeColorWithColor(ctx, color);
    
    CGContextBeginPath(ctx);
    
    for (NSUInteger i = 0; i<[self.delegate mobGraphLineNumberOfItems:self]; i++) {
        id<MOBGraphPointDelegate> obj = [self.delegate mobGraph:self pointAtPosition:i];
        
        CGFloat x = kGraphPadding + ( ([obj mobGraphPointX] / xMax) * (self.frame.size.width- 2*kGraphPadding));
        CGFloat y = self.frame.size.height-(kGraphPadding + ((((([obj mobGraphPointY]-yMin)/ (yMax-yMin))- 0) * (self.frame.size.height - 2*kGraphPadding))));
        if (i==0) {
            CGContextMoveToPoint(ctx, x,y);
        }else{
            CGContextAddLineToPoint(ctx, x, y);
        }
    }
    
    if (self.gestureRecognizers.count==0) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:gesture];
    }
    
    CGContextDrawPath(ctx, kCGPathStroke);
}
#pragma mark - gesture rec
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    CGPoint point =[sender locationInView:self];
    
    float percent = (point.x/self.frame.size.width);
    
    NSUInteger numberOfItems = [self.delegate mobGraphLineNumberOfItems:self];
    NSUInteger selectedPosition = floor(numberOfItems * percent);
    
    if ([self.delegate respondsToSelector:@selector(mobGraph:didSelectedPointAtPosition:)]) {
        [self.delegate mobGraph:self didSelectedPointAtPosition:selectedPosition];
    }
}

@end
