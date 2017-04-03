//
//  FunctionKeyAction.m
//  OctopusTouch
//
//
//  Created by icoco.
//


#import "FunctionKeyAction.h"
#import "QTProcessor.h"
#import "CommandMananger.h"
@implementation FunctionKeyAction

- (void) execute:(NSString*)keystores{
    
    NSString* functionKeys = [self.parametres valueForKey:kFunctionKey];
    NSString* plainKey = [self.parametres valueForKey:kPlainKey];
    
    QTShortCutsModel * cmd = [QTShortCutsModel new];
    cmd.functionKeys = @[functionKeys];
    cmd.plainKey = plainKey;
    
    QTTypeModel *qtTypeModel = [QTTypeModel new];
    qtTypeModel.qtDesc = [NSString stringWithFormat:@"%@-%@", functionKeys, plainKey];
    qtTypeModel.qtType = QTShortCuts;
    qtTypeModel.qtContent = cmd;
    
    [[QTProcessor sharedInstance] sendQTTypeModel:qtTypeModel];

    
}



@end
