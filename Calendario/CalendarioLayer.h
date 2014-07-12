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
///MicBlow
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

// CalendarioLayer
@interface CalendarioLayer : CCLayer 
{
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
//
- (void)handleShakeMotion:(NSNotification *)notification;
+ (void)rotateCalendarioWithDate:(NSDate *)dateValue;
- (void)addDateLabel;
- (void)updateDateLable:(NSString *)dateValue;
//
-(void)setupMicBlowDetection;
- (void)levelTimerCallback:(NSTimer *)timer;
@end
