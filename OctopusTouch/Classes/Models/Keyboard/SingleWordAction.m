//
//  SingleWordAction.m
//  OctopusTouch
//
//  Created by icoco.

//

#import "SingleWordAction.h"
#import "QTProcessor.h"
#import <LocalAuthentication/LocalAuthentication.h>


@implementation SingleWordAction

- (void) execute:(NSString*)keystores{
    NSString* content = [self.parametres valueForKey:@"content"];
    
    QTSingleWordModel *qtSingleWordModel = [QTSingleWordModel new];
    qtSingleWordModel.content =content;
    
    QTTypeModel *qtTypeModel = [QTTypeModel new];
    qtTypeModel.qtDesc = content;
    qtTypeModel.qtType = QTSingleWord;
    qtTypeModel.qtContent = qtSingleWordModel;
     [[QTProcessor sharedInstance] sendQTTypeModel:qtTypeModel];
}



 

@end
