//
//  MOBViewController.m
//  LineGraphViewDelegate
//
//  Created by Jakub Dubrovsky on 08/13/2014.
//  Copyright (c) 2014 Jakub Dubrovsky. All rights reserved.
//

#import "MOBViewController.h"

#import "MOBModel.h"

@interface MOBViewController ()

@end

@implementation MOBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MOBGraphLineDelegate

- (NSUInteger) mobGraphLineNumberOfItems: (MOBGraphLineView *) graph
{
    return 100;
}


- (NSUInteger) mobGraphLineNumberOfYlines: (MOBGraphLineView *) graph
{
    return 1;
}

- (id<MOBGraphPointDelegate>) mobGraph: (MOBGraphLineView *) graph pointAtPosition:(NSUInteger) position
{
    MOBModel *m = [[MOBModel alloc] init];
    m.x =   position;
    m.y =   arc4random_uniform(100);
    return m;
}

- (UIColor *) mobGraphColor: (MOBGraphLineView *) graph
{
    return [UIColor yellowColor];
}


- (void)mobGraph:(MOBGraphLineView *)graph didSelectedPointAtPosition:(NSUInteger)position
{
    NSLog(@"Point at position %@ was selected", @(position));
    
    
    float percent = (float)position / [self mobGraphLineNumberOfItems:graph];
    float positionX = graph.frame.size.width * percent;
    
    UIView *annotationGraphView = [[UIView alloc] init];
    [annotationGraphView setBackgroundColor:[UIColor colorWithRed:0.071 green:0.544 blue:0.199 alpha:1.000]];
    [annotationGraphView setFrame:CGRectMake(positionX-3, 0, 6, graph.frame.size.height)];
    
    [graph addSubview: annotationGraphView];
    
}
@end
