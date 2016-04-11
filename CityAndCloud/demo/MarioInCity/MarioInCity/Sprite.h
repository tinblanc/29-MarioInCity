//
//  Sprite.h
//  MarioInCity
//
//  Created by Tin Blanc on 4/9/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "Scene.h"

@class Scene; // khai báo class chuyển tiếp

@interface Sprite : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) NSString* name;
@property(nonatomic,weak) Scene* scene;

-(instancetype) initWithName: (NSString*) name
                     ownView: (UIView*) view
                     inScene: (Scene*) scene;

-(void) animate;
@end
