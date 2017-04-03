//
//  Action.m
//
//
//  Created by icoco
 
//

#import "Action.h"
#import "QTProcessor.h"
#import <LocalAuthentication/LocalAuthentication.h>



@implementation Action

- (void) execute:(NSString*)keystores{
    
    [self cmdTab];
    
}

- (void)cmdTab{
    NSString* content = [self.parametres valueForKey:@"functionKeys"];
    QTShortCutsModel * cmd = [QTShortCutsModel new];
    //qtSingleWordModel.content = @"DOWN";
    cmd.functionKeys = @[@"Command"];
    cmd.plainKey = @"TAB";
    QTTypeModel *qtTypeModel = [QTTypeModel new];
    qtTypeModel.qtDesc = @"cmdTab";
    qtTypeModel.qtType = QTShortCuts;
    qtTypeModel.qtContent = cmd;
    
    [[QTProcessor sharedInstance] sendQTTypeModel:qtTypeModel];
    
}

@end
