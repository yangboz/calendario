//
//  CalAnnulusLayer.m
//  Calendario
//
//  Created by zhou Yangbo on 12-10-24.
//  Copyright 2012年 GODPAPER. All rights reserved.
//

#import "CalAnnulusLayer.h"


@implementation CalAnnulusLayer
@synthesize img_calendario;

-(id) initWithImagePath:(NSString *)path
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		//
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //
        img_calendario = [[UIImageView alloc]initWithImage:[UIImage imageNamed:path]];
        //        calendario_00 =  [[CCSprite alloc] initWithCGImage: [img_calendario_00 CGImage] key: @"calendario_00"];
        //        [self addChild:calendario_00];
        [[[CCDirector sharedDirector] openGLView] addSubview:img_calendario];
        [[[CCDirector sharedDirector] openGLView] sendSubviewToBack:img_calendario];
        [img_calendario setCenter:ccp(screenSize.width/2.0f,screenSize.height/2.0f)];
        
        // Custom initialization
        imageAngle = 0;
        [self setupGestureRecognizer];
        [self updateTextDisplay];
	}
	return self;
}


#pragma mark - CircularGestureRecognizerDelegate protocol

- (void) rotation: (CGFloat) angle
{
    // calculate rotation angle
    imageAngle += angle;
    if (imageAngle > 360)
        imageAngle -= 360;
    else if (imageAngle < -360)
        imageAngle += 360;
    
    // rotate image and update text field
    img_calendario.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
    //    [self updateTextDisplay];
}

- (void) finalAngle: (CGFloat) angle
{
    // circular gesture ended, update text field
    //    [self updateTextDisplay];
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
    [[[CCDirector sharedDirector] openGLView] removeGestureRecognizer: gestureRecognizer];
    
    // improvement opportunity: translate the rotation angle
    imageAngle = 0;
    img_calendario.transform = CGAffineTransformIdentity;
}
// ... and added afterwards.
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setupGestureRecognizer];
    [self updateTextDisplay];
}

#pragma mark - Helper methods

// Updates the text field with the current rotation angle.
- (void) updateTextDisplay
{
    //    textDisplay.text = [NSString stringWithFormat: @"\u03b1 = %.2f", imageAngle];
}
// Addes gesture recognizer to the view (or any other parent view of image. Calculates midPoint
// and radius, based on the image position and dimension.
- (void) setupGestureRecognizer
{
    // calculate center and radius of the control
    CGPoint midPoint = CGPointMake(img_calendario.frame.origin.x + img_calendario.frame.size.width / 2,
                                   img_calendario.frame.origin.y + img_calendario.frame.size.height / 2);
    CGFloat outRadius = img_calendario.frame.size.width / 2;
    
    // outRadius / 3 is arbitrary, just choose something >> 0 to avoid strange 
    // effects when touching the control near of it's center
    gestureRecognizer = [[OneFingerRotationGestureRecognizer alloc] initWithMidPoint: midPoint
                                                                         innerRadius: outRadius / 3 
                                                                         outerRadius: outRadius
                                                                              target: self];
    //    [self.view addGestureRecognizer: gestureRecognizer];
    [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:gestureRecognizer];
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
    img_calendario = nil;
    gestureRecognizer = nil;
}
@end
