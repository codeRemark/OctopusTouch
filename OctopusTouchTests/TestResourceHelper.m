//
//  TestResourceHelper.m
//  OctopusTouch
//
//  Created by icoco7 on 30/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Resources.h"

#import "ResourceHelper.h"

@interface TestResourceHelper : XCTestCase

@end

@implementation TestResourceHelper

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSURL* folder = [Resources getAppSupportDirectory];
    NSString* source = @"Site";
    NSString* target =[NSString stringWithFormat:@"%@/%@",  [folder path],   source  ];
    
    [ResourceHelper copyBundleFile:source targetPath:target];
}

@end
