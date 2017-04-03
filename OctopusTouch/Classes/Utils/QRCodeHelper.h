//
//  QRCodeHelper.h
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeHelper : NSObject

+ (NSImage*)generate:(NSString*)content;

@end
