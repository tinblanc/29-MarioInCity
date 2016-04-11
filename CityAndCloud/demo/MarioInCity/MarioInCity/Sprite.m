//
//  Sprite.m
//  MarioInCity
//
//  Created by Tin Blanc on 4/9/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

-(instancetype) initWithName:(NSString *)name
                     ownView:(UIView *)view
                     inScene:(Scene *)scene {
    if (self = [super init]) {
        self.name = name;
        self.view = view;
        self.scene = scene;
    }
    return self;
    
}

-(void) animate {

}

@end
