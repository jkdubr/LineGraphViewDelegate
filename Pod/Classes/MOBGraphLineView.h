//
//  MOBGraphLineView.h
//  MyGraph
//
//  Created by Jakub Dubrovsky on 11/05/14.
//  Copyright (c) 2014 Mobera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOBGraphLineView;



@protocol MOBGraphPointDelegate <NSObject>
//x,y,
- (NSUInteger) mobGraphPointY;
- (NSUInteger) mobGraphPointX;
@end

@protocol MOBGraphLineDelegate <NSObject>

- (NSUInteger) mobGraphLineNumberOfItems: (MOBGraphLineView *) graph;

- (id<MOBGraphPointDelegate>) mobGraph: (MOBGraphLineView *) graph pointAtPosition:(NSUInteger) position;
- (UIColor *) mobGraphColor: (MOBGraphLineView *) graph;
- (NSUInteger) mobGraphLineNumberOfYlines: (MOBGraphLineView *) graph;

@optional
- (void) mobGraph: (MOBGraphLineView *) graph didSelectedPointAtPosition:(NSUInteger) position;
- (id<MOBGraphPointDelegate>) mobGraph: (MOBGraphLineView *) graph yLineAtPosition:(NSUInteger) position;

@end

@interface MOBGraphLineView : UIView

@property(nonatomic, weak) IBOutlet id<MOBGraphLineDelegate> delegate;
@end