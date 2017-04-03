//
//  ShortCutKeyAction.m
//  OctopusTouch
//
//  Created by icoco7 on 31/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "ShortCutKeyAction.h"
#import "QTProcessor.h"


@implementation ShortCutKeyAction

- (void) execute:(NSString*)keystores{
    NSString* content = [self.parametres valueForKey:@"content"];
    
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
