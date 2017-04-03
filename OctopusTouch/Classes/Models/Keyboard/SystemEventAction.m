//
//  SystemEventAction.m
//  OctopusTouch
//
//
//  Created by icoco.
//
#import "SystemEventAction.h"
#import "QTProcessor.h"
#import "CommandMananger.h"
#import "NSString+KeyCode.h"
#import "CKStringUtils.h"

@implementation SystemEventAction

- (void) execute:(NSString*)keystores{
    NSString* sys = [self.parametres valueForKey: kSysEventCode];
    int code = [sys intValue];
    QTSystemEventModel *qtSystemEventModel = [QTSystemEventModel new];
    qtSystemEventModel.qtSystemEventType = code ;//  QTSystemEventBrightness;
    
    NSDictionary* params = [NSDictionary dictionary];
    NSString*  str = [self.parametres valueForKey:kSysEventParams];
    if (![CKStringUtils isEmpty:str]){
        params  = [str toJsonDicationary];
        // qtSystemEventModel.paras = @{@"brightness":number};
        NSLog(@"params-.%@",params);
        qtSystemEventModel.paras = params;
    }
 
    
    QTTypeModel *qtTypeModel = [QTTypeModel new];
    qtTypeModel.qtDesc = [params description];
    qtTypeModel.qtType = QTSystemEvent;
    qtTypeModel.qtContent = qtSystemEventModel;

    [[QTProcessor sharedInstance] sendQTTypeModel:qtTypeModel];
}
@end
