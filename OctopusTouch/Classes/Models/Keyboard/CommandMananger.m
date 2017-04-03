//
//  CommandMananger.m
//  OctopusTouch
//
//  Created by icoco
//

#import "CommandMananger.h"
#import "Action.h"
#import "CKStringUtils.h"
#import "GCDWebServerURLEncodedFormRequest.h"

@implementation CommandMananger

static CommandMananger* _sharedInstance = nil;

+(CommandMananger*)sharedInstance{
    if(!_sharedInstance){
        _sharedInstance = [[CommandMananger alloc] init];
    }
    return _sharedInstance;
}

+ (NSObject*)instanceClassWithName:(NSString*)name{
    NSLog(@"instanceClassWithName:%@",name);
    Class class = NSClassFromString(name);
    NSObject *result   = [class new];
    return result;
}


+ (Action*)createActionWithRequest:(NSDictionary*)params{
    if (nil == params || [params count]<=0){
        return  nil;
    }
    NSString* className =  @"Action";
    if (![CKStringUtils isEmpty:className]){
           className = [params valueForKey:@"type"];
    }
    
    return [CommandMananger instanceClassWithName:className];
}

- (void) onRequest:(GCDWebServerRequest* ) request {
       NSLog(@"onRequest->%@",  request);
    NSDictionary* params = request.query;
    if (nil == params || [params count]<=0){
        params=  ( (GCDWebServerURLEncodedFormRequest*)request).arguments ;
    }
    NSLog(@"onRequest params->%@",  params);
    Action* action = [CommandMananger createActionWithRequest:params];
    if (nil == action){
        NSLog(@"No mathed action ! ->%@" , request);
        return ;
    }
    action.parametres = params;
    
    [action execute:@""];
}
@end
