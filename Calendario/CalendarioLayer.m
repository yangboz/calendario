//
//  HelloWorldLayer.m
//  Calendario
//
//  Created by zhou Yangbo on 12-10-22.
//  Copyright GODPAPER 2012年. All rights reserved.
//


// Import the interfaces
#import "CalendarioLayer.h"
//

// CalendarioLayer implementation
@implementation CalendarioLayer

//@interface CalendarioLayer ()
//{
 CGFloat imageAngle;
 OneFingerRotationGestureRecognizer *gestureRecognizer;
//Image views
 UIImageView *img_calendario_00;
 UIImage *img_calendario_01;
 UIImage *img_calendario_02;
 UIImage *img_calendario_03;
 CCSprite *calendario_00;
 CCSprite *calendario_01;
 CCSprite *calendario_02;
 CCSprite *calendario_03;    
//}

//- (void) updateTextDisplay;
//- (void) setupGestureRecognizer;
//@end

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CalendarioLayer *layer = [CalendarioLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
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
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
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
        
        //
//        UIImageView *foo = [[UIImageView alloc]initWithFrame:CGRectMake(100.0, 100.0, 600, 800.0)];
//        foo.userInteractionEnabled = YES;
//        foo.multipleTouchEnabled  = YES;
//        foo.image = [UIImage imageNamed:@"earth.jpg"];
//        foo.contentMode = UIViewContentModeScaleAspectFit;
//        foo.clipsToBounds = YES;
//        img_calendario_00 = [UIImage imageNamed:@"calendario_00.png"];
        img_calendario_00 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendario_00.png"]];
//        calendario_00 =  [[CCSprite alloc] initWithCGImage: [img_calendario_00 CGImage] key: @"calendario_00"];
//        [self addChild:calendario_00];
        [[[CCDirector sharedDirector] openGLView] addSubview:img_calendario_00];
        [[[CCDirector sharedDirector] openGLView] sendSubviewToBack:img_calendario_00];
        [img_calendario_00 setCenter:ccp(screenSize.width/2.0f,screenSize.height/2.0f)];
        
        //
        img_calendario_01 = [UIImage imageNamed:@"calendario_01.png"];
        calendario_01 =  [[CCSprite alloc] initWithCGImage: [img_calendario_01 CGImage] key: @"calendario_01"];
        [self addChild:calendario_01];
        calendario_01.position = ccp(screenSize.width/2.0f,screenSize.height/2.0f);
        
        //
        img_calendario_02 = [UIImage imageNamed:@"calendario_02.png"];
        calendario_02 =  [[CCSprite alloc] initWithCGImage: [img_calendario_02 CGImage] key: @"calendario_02"];
        [self addChild:calendario_02];
        calendario_02.position = ccp(screenSize.width/2.0f,screenSize.height/2.0f);
        
        //
        img_calendario_03 = [UIImage imageNamed:@"calendario_03.png"];
        calendario_03 =  [[CCSprite alloc] initWithCGImage: [img_calendario_03 CGImage] key: @"calendario_03"];
        [self addChild:calendario_03];
        calendario_03.position = ccp(screenSize.width/2.0f,screenSize.height/2.0f);
        
        //Gestures
        //---rotate gesture--- 
//        UIRotationGestureRecognizer *rotateGesture = [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)] autorelease];
//        [rotateGesture setDelegate:self];
//        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:rotateGesture];
        //---pinch gesture---
        UIPinchGestureRecognizer *pinchGesture = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)] autorelease];
        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinchGesture];
        
        // Custom initialization
        imageAngle = 0;
        [self setupGestureRecognizer];
        [self updateTextDisplay];
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
    img_calendario_00.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
//    [self updateTextDisplay];
}

- (void) finalAngle: (CGFloat) angle
{
    // circular gesture ended, update text field
//    [self updateTextDisplay];
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
    CGPoint midPoint = CGPointMake(img_calendario_00.frame.origin.x + img_calendario_00.frame.size.width / 2,
                                   img_calendario_00.frame.origin.y + img_calendario_00.frame.size.height / 2);
    CGFloat outRadius = img_calendario_00.frame.size.width / 2;
    
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
}
@end
