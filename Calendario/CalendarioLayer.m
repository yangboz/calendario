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
//

// CalendarioLayer implementation
@implementation CalendarioLayer

//Annuluss
CalAnnulusLayer *monthLayer;
CalAnnulusLayer *dayLayer;
CalAnnulusLayer *eightTrigramLayer;
CalAnnulusLayer *compassLayer;
//
UIPinchGestureRecognizer *pinchGesture;

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
	compassLayer = [[CalAnnulusLayer node] initWithImagePath:@"calendario_03.png"];
	// add layer as a child to scene
	[scene addChild: monthLayer];
    [scene addChild: dayLayer];
    [scene addChild: eightTrigramLayer];
    [scene addChild: compassLayer];
//    [monthLayer setPosition:CGPointMake(100, 100)];
	
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
        
	}
	return self;
}

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
}
@end
