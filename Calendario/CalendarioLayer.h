//
//  HelloWorldLayer.h
//  Calendario
//
//  Created by zhou Yangbo on 12-10-22.
//  Copyright GODPAPER 2012年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import <UIKit/UIKit.h>
#import "cocos2d.h"

// CalendarioLayer
@interface CalendarioLayer : CCLayer 
{
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
//
- (void)handleShakeMotion:(NSNotification *)notification;
@end
