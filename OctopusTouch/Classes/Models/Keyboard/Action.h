//
//  Action.h
//  OctopusTouch
//
//  Created by icoco.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject

@property(nonatomic)NSDictionary* parametres;

- (void) execute:(NSString*)keystores;

@end
