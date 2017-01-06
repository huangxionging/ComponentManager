//
//  CMQRCodeManager.m
//  Hydrodent
//
//  Created by huangxiong on 2016/12/20.
//  Copyright © 2016年 xiaoli. All rights reserved.
//

#import "CMQRCodeManager.h"
#import <CoreImage/CoreImage.h>

@implementation CMQRCodeManager

+ (UIImage *)encodeWithObject:(id)object size:(CGSize)size {
    if (!object) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *data = nil;
    if ([object isKindOfClass: [NSArray class]] || [object isKindOfClass: [NSDictionary class]]) {
       data = [NSJSONSerialization dataWithJSONObject: object options: NSJSONWritingPrettyPrinted error: &error];
    } else {
        NSString *text = [NSString stringWithFormat: @"%@", object];
        data = [text dataUsingEncoding: NSUTF8StringEncoding];
    }
    
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    UIImage *codeImage = nil;
    CIFilter *qrFilter = [CIFilter filterWithName: @"CIQRCodeGenerator"];
    [qrFilter setValue:data forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    return codeImage;
}

+ (NSString *)decodeWithImage:(UIImage *)image {
    UIImage *srcImage = image;
    CIContext *context = [CIContext context];
    CIDetector *detector = [CIDetector detectorOfType: CIDetectorTypeQRCode context: context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *qrImage = [CIImage imageWithCGImage: srcImage.CGImage];
    NSArray *features = [detector featuresInImage: qrImage];
    CIQRCodeFeature *feature = [features firstObject];
    NSString *result = [feature messageString];
    return result;
}

@end
