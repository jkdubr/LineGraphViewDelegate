//
//  MOBModel.h
//  MyGraph
//
//  Created by Jakub Dubrovsky on 11/05/14.
//  Copyright (c) 2014 Mobera. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MOBGraphLineView.h"

@interface MOBModel : NSObject<MOBGraphPointDelegate>

@property(nonatomic) NSUInteger x;
@property(nonatomic) NSUInteger y;



@end
