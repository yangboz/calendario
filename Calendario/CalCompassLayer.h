//
//  CalCompassLayer.h
//  Calendario
//
//  Created by zhou Yangbo on 12-10-25.
//  Copyright 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//CoreLocation
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
//
#import "BSForwardGeocoder.h"
#import "BSKmlResult.h"

@interface CalCompassLayer : CCLayer <CLLocationManagerDelegate,BSForwardGeocoderDelegate>
{
    //Image views
    UIImageView *img_calendario;
    //CoreLocation
    CLLocationManager *locationManager;
    
    CLLocationCoordinate2D currentLocation;
    CLLocationDirection currentHeading;
    
    CLLocationCoordinate2D cityLocation;
    CLLocationDirection cityHeading;
    
    BSForwardGeocoder *forwardGeocoder;
}
-(id) initWithImagePath:(NSString *)path;
//Properties
@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic) CLLocationDirection currentHeading;
@end
