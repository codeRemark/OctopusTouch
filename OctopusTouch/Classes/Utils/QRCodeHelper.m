//
//  QRCodeHelper.m
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "QRCodeHelper.h"
#import "QREncoder.h"

#define QR_CODE_IMAGE_DIMENSION 350

@implementation QRCodeHelper

+ (NSImage*)generate:(NSString*)content{
    //first encode the string into a matrix of bools, TRUE for black dot and FALSE for white. Let the encoder decide the error correction level and version
    DataMatrix* qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:content];
    NSImage* result = [QREncoder renderDataMatrix:qrMatrix imageDimension:QR_CODE_IMAGE_DIMENSION];
    return result;
}
@end
