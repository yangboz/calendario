//
//  CalAnnulusLayer.h
//  Calendario
//
//  Created by zhou Yangbo on 12-10-24.
//  Copyright 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "OneFingerRotationGestureRecognizer.h"

@interface CalAnnulusLayer : CCLayer <OneFingerRotationGestureRecognizerDelegate>
{
    //Gesture
    OneFingerRotationGestureRecognizer *gestureRecognizer;
    //Image views
    UIImageView *img_calendario;
    CGFloat imageAngle;
}
-(id) initWithImagePath:(NSString *)path;
//
-(void)setupGestureRecognizer;
-(void)updateTextDisplay;

@end
