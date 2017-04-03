//
//  PasteAction.m
//  OctopusTouch
//
//  Created by icoco7 on 31/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "PasteAction.h"
#import "QTProcessor.h"
#import "PasteBoardMananger.h"

@implementation PasteAction

- (void) execute:(NSString*)keystores{
    NSString* content = [self.parametres valueForKey:@"content"];
    [PasteBoardMananger write2PasteBoard:content];
    //@step
    QTShortCutsModel *qtShortCutsModel = [QTShortCutsModel new];
    // qtShortCutsModel.functionKeys = @[@"Command", @"Shift"];
    qtShortCutsModel.functionKeys = @[@"Command"];
    
    qtShortCutsModel.plainKey = @"V";
    
    QTTypeModel *qtTypeModel = [QTTypeModel new];
    qtTypeModel.qtDesc = @"Command + V";
    qtTypeModel.qtType = QTShortCuts;
    qtTypeModel.qtContent = qtShortCutsModel;
    
    [[QTProcessor sharedInstance] sendQTTypeModel:qtTypeModel];
}



@end
