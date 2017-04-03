//
//  AppResource.h
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString*  AppLocalizedString(NSString* key);
FOUNDATION_EXPORT NSString*  AppLocalizedStringWithDefaultValue(NSString* key, NSString* defaultValue);

FOUNDATION_EXPORT NSArray*  AppLocalizedStringArray(NSString* key);

FOUNDATION_EXPORT NSObject *AppResourceGet(const  NSString* aKey,    const NSObject* defaultValue);
FOUNDATION_EXPORT NSObject *AppResourceSet( const NSString* aKey,    NSObject* defaultValue);

@interface AppResource : NSObject

@end
