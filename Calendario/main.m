//
//  main.m
//  Calendario
//
//  Created by zhou Yangbo on 12-10-22.
//  Copyright GODPAPER 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "QTouchposeApplication.h"

int main(int argc, char *argv[]) {
    /*
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return retVal;
    */

    return UIApplicationMain(argc, argv,
                                 NSStringFromClass([QTouchposeApplication class]),
                                 NSStringFromClass([AppDelegate class]));
}
