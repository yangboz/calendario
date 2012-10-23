//
//  HelloWorldLayer.h
//  Calendario
//
//  Created by zhou Yangbo on 12-10-22.
//  Copyright GODPAPER 2012年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "OneFingerRotationGestureRecognizer.h"
// CalendarioLayer
@interface CalendarioLayer : CCLayer <OneFingerRotationGestureRecognizerDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
