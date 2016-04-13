//
//  Block.m
//  MarioInCity
//
//  Created by Tin Blanc on 4/9/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Block.h"

@implementation Block

-(instancetype) initWithName:(NSString *)name inScene:(Scene *)scene {
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block"]]
                       inScene:scene];
    
    return self;
}

@end
