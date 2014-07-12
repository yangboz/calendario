//
//  HelloWorldLayer.m
//  Calendario
//
//  Created by zhou Yangbo on 12-10-22.
//  Copyright GODPAPER 2012年. All rights reserved.
//


// Import the interfaces
#import "CalendarioLayer.h"
#import "CalAnnulusLayer.h"
#import "CalCompassLayer.h"
//
#import "UIResponder+MotionRecognizers.h"
#import <QuartzCore/QuartzCore.h>
// CalendarioLayer implementation
@implementation CalendarioLayer 

//Annuluss
CalAnnulusLayer *monthLayer;//veintena
CalAnnulusLayer *dayLayer;//trecena
CalAnnulusLayer *eightTrigramLayer;
//CalAnnulusLayer *compassLayer;
CalCompassLayer *compassLayer;
//
UIPinchGestureRecognizer *pinchGesture;
//1） 已知日期在一年中的序号（tday），求卓尔金日期（td--trd）：
//　　公式：tday = 13tm + td = 20trm + trd（td等于0时加13，trd等于0时加20）
//　　如：第168天被13除后余12，被20除后余8，第8个符号为Lamat。得卓尔金日期为12Lamat。
//（2） 已知卓尔金日期（td--trd），求其在一年中的序号（tday）：
//　　公式：13tm - 20trm = trd - td, tday = 13tm + td
//　　方程中的变量均为整数，且 0<tday<261，因此可求出唯一的解。
//More:http://baike.baidu.com/view/1490900.htm

NSInteger daysInYear;
NSInteger daysInYearMaya;
NSInteger dayInYearMaya;
NSInteger monthInYearMaya;
NSInteger hoursInYearMaya;
CGFloat dayAngle;
CGFloat monthAngle;
CGFloat hoursAngle;//3hours

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CalendarioLayer *layer = [CalendarioLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    // 'layer' is an autorelease object.
	monthLayer = [[CalAnnulusLayer node] initWithImagePath:@"calendario_00.png"];
	dayLayer = [[CalAnnulusLayer node] initWithImagePath:@"calendario_01.png"];
    eightTrigramLayer = [[CalAnnulusLayer node] initWithImagePath:@"calendario_02.png"];
	compassLayer = [[CalCompassLayer node] initWithImagePath:@"calendario_03.png"];
	// add layer as a child to scene
	[scene addChild: monthLayer];
    [scene addChild: dayLayer];
    [scene addChild: eightTrigramLayer];
    [scene addChild: compassLayer];
//    [monthLayer setPosition:CGPointMake(100, 100)];
    //Layer rotation initilize
    NSDate *today = [NSDate date];
    [self rotateCalendarioWithDate:today];
	// return the scene
	return scene;
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		//
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//		// create and initialize a Label
//		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
//
//		// ask director the the window size
//		CGSize size = [[CCDirector sharedDirector] winSize];
//	
//		// position the label on the center of the screen
//		label.position =  ccp( size.width /2 , size.height/2 );
//		
//		// add the label as a child to this Layer
//		[self addChild: label];
        
        //Gestures
        //---rotate gesture--- 
//        UIRotationGestureRecognizer *rotateGesture = [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)] autorelease];
//        [rotateGesture setDelegate:self];
//        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:rotateGesture];
        //---pinch gesture---
        pinchGesture = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)] autorelease];
        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinchGesture];
        // Step 2 - Register for motion event:
        //[self addMotionRecognizerWithAction:@selector(motionWasRecognized:)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleShakeMotion:) name:@"handleShakeMotion" object:nil];
	}
	return self;
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    //
    pinchGesture = nil;
    //
}

#pragma mark -Gestures(rotate,pinch..)
-(IBAction)handleRotateGesture:(UIGestureRecognizer *)sender
{
    CGFloat netRotation = 0.0f;
    CGFloat rotation = CC_RADIANS_TO_DEGREES([(UIRotationGestureRecognizer *)sender rotation]);
    CGAffineTransform transform = CGAffineTransformMakeRotation(rotation+netRotation);
    sender.view.transform = transform;
    if (sender.state == UIGestureRecognizerStateEnded) {
        netRotation += rotation;
    }
}

-(IBAction)handlePinchGesture:(UIGestureRecognizer *)sender
{
    CGFloat lastScaleFactor = 1.0f;
    CGFloat factor = [ (UIPinchGestureRecognizer*) sender scale];
    if ( factor >1) {
        //Zoom in---
        sender.view.transform = CGAffineTransformMakeScale(lastScaleFactor + (factor-1), lastScaleFactor + (factor-1));
    }else {
        //Zoom out---
        sender.view.transform = CGAffineTransformMakeScale(lastScaleFactor*factor, lastScaleFactor*factor);
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (factor>1) {
            lastScaleFactor += factor-1;
        }else {
            lastScaleFactor *=factor;
        }
    }
}


#pragma mark - UIViewController methods 

// Any rotation is supported.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// To make things easier, the gesture recognizer is removed before rotation...
- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
                                 duration: (NSTimeInterval) duration
{
    [[[CCDirector sharedDirector] openGLView] removeGestureRecognizer: pinchGesture];
}
// ... and added afterwards.
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{

}

#pragma  mark -ShakeMotion

//- (void) motionWasRecognized:(NSNotification*)notif
- (void)handleShakeMotion:(NSNotification *)notification
{
    //id liquid = [CCLiquid actionWithWaves:6 amplitude:20 grid:ccg(15, 10) duration:3];
    id shaky3D = [CCShaky3D actionWithRange:10 shakeZ:NO grid:ccg(15, 10) duration:5];
    //id shaky3D = [CCShaky3D actionWithDuration:3.00];
    
    //No need to unschedule after 3 seconds since you already set duration-^ to 3 seconds.
    [self runAction:shaky3D];
    
    //Reset mannually rotation
    NSDate *today = [NSDate date];
    [CalendarioLayer rotateCalendarioWithDate:today];
}
#pragma mark -RotateMotion
+ (void)rotateCalendarioWithDate:(NSDate *)dateVaule;
{
    //	NSDate *date = [NSDate date];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSDateComponents *components = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:date];
    //    NSInteger year = [components year];
    //    NSInteger month = [components month];
    //    NSInteger day = [components day];
    //    NSInteger hour = [components hour];
    //    NSInteger minute = [components minute];
    //    NSLog(@"%d/%d/%d/ %d:%d", year,month,day,hour, minute);
    //
//    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"DDDD"];
    daysInYear = [[dateFormat stringFromDate:dateVaule] integerValue];
    daysInYearMaya = daysInYear % 260;
    dayInYearMaya = daysInYearMaya % 13;
    monthInYearMaya = daysInYearMaya / 20;
    //
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:dateVaule];
    hoursInYearMaya = [components hour];
    NSLog(@"Today is: %ld . days in year.Maya days is: %ld,Maya month is: %ld,Maya day is: %ld,Maya hours is: %ld", (long)daysInYear, (long)daysInYearMaya,(long)monthInYearMaya, (long)dayInYearMaya,(long)hoursInYearMaya);
    //image rotation angle calculate
    dayAngle = 1 * (dayInYearMaya/13.0);
    monthAngle = 1 * (monthInYearMaya/20.0);
    hoursAngle = 1 * (hoursInYearMaya/8.0);
    //Initialize the calendario component's rotation property.
    dayLayer.img_calendario.transform = CGAffineTransformMakeRotation(dayAngle);
    monthLayer.img_calendario.transform = CGAffineTransformMakeRotation(monthAngle);
    eightTrigramLayer.img_calendario.transform = CGAffineTransformMakeRotation(hoursAngle);
    //Release
    [dateFormat release];
}
@end
