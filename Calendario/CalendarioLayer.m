//
//  HelloWorldLayer.m
//  Calendario
//
//  Created by zhou Yangbo on 12-10-22.
//  Copyright GODPAPER 2012年. All rights reserved.
//


// Import the interfaces
#import "CalendarioLayer.h"

// CalendarioLayer implementation
@implementation CalendarioLayer

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
        UIImage *img_calendario_00 = [UIImage imageNamed:@"calendario_00.png"];
        CCSprite *calendario_00 =  [[CCSprite alloc] initWithCGImage: [img_calendario_00 CGImage] key: @"calendario_00"];
        [self addChild:calendario_00];
        calendario_00.position = ccp(screenSize.width/2.0f,screenSize.height/2.0f);
        
        //
        UIImage *img_calendario_01 = [UIImage imageNamed:@"calendario_01.png"];
        CCSprite *calendario_01 =  [[CCSprite alloc] initWithCGImage: [img_calendario_01 CGImage] key: @"calendario_01"];
        [self addChild:calendario_01];
        calendario_01.position = ccp(screenSize.width/2.0f,screenSize.height/2.0f);
        
        //
        UIImage *img_calendario_02 = [UIImage imageNamed:@"calendario_02.png"];
        CCSprite *calendario_02 =  [[CCSprite alloc] initWithCGImage: [img_calendario_02 CGImage] key: @"calendario_02"];
        [self addChild:calendario_02];
        calendario_02.position = ccp(screenSize.width/2.0f,screenSize.height/2.0f);
        
        //
        UIImage *img_calendario_03 = [UIImage imageNamed:@"calendario_03.png"];
        CCSprite *calendario_03 =  [[CCSprite alloc] initWithCGImage: [img_calendario_03 CGImage] key: @"calendario_03"];
        [self addChild:calendario_03];
        calendario_03.position = ccp(screenSize.width/2.0f,screenSize.height/2.0f);
        
        //Gestures
        //---rotate gesture--- 
        UIRotationGestureRecognizer *rotateGesture = [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)] autorelease];
        [rotateGesture setDelegate:self];
        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:rotateGesture];
	}
	return self;
}

-(IBAction)handleRotateGesture:(UIGestureRecognizer *)sender
{
    CGFloat netRotation = 0.0f;
    CGFloat rotation = [(UIRotationGestureRecognizer *)sender rotation];
    CGAffineTransform transform = CGAffineTransformMakeRotation(rotation+netRotation);
    sender.view.transform = transform;
    if (sender.state == UIGestureRecognizerStateEnded) {
        netRotation += rotation;
    }
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
