//
//  FireBall.m
//  MarioInCity
//
//  Created by Tin Blanc on 4/12/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "FireBall.h"

@implementation FireBall

-(instancetype) initWithName:(NSString *)name inScene:(Scene *)scene {
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fireball"]]
                       inScene:scene];
    return self;
}

-(void) startFly:(CGFloat)speed {
    if (!self.isFlying) {
        self.isFlying = true;
        self.speed = speed;
    }
}

-(void) fly {
    if (!self.isFlying) return;
    CGFloat x = self.view.center.x + self.speed;
    
    if (x > self.scene.size.width + self.view.bounds.size.width * 0.5) { // fireball đi ra ngoài màn hình
        [self.scene removeSprite:self];
        return;
    }
    
    self.view.center = CGPointMake(x, self.view.center.y);

    
}

-(void) animate {
    [self fly];
}

@end
