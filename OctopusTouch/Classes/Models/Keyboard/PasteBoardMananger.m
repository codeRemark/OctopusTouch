//
//  PasteBoardMananger.m
//  OctopusTouch
//
//  Created by icoco7 on 31/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "PasteBoardMananger.h"

@implementation PasteBoardMananger

+(void)write2PasteBoard:(NSString*)content{
    [[NSPasteboard generalPasteboard]
     declareTypes: [NSArray arrayWithObject: NSStringPboardType]
     owner:nil];
    [[NSPasteboard generalPasteboard]
     setString: content
     forType: NSStringPboardType];
}

@end
