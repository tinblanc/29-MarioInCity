//
//  Cloud.m
//  MarioInCity
//
//  Created by Tin Blanc on 4/9/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Cloud.h"

@implementation Cloud

-(void) animate{
    self.view.center = CGPointMake(self.view.center.x + self.speed, self.view.center.y);
    
    if (self.view.frame.origin.x + self.view.bounds.size.width < 0) {
        self.view.center = CGPointMake(self.scene.size.width + self.view.bounds.size.width * 0.5, self.view.center.y);
    }
    
}

@end
