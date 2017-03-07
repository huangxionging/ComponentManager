//
//  CMImageManager.m
//  ComponentManager
//
//  Created by huangxiong on 2017/1/3.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import "CMImageManager.h"

@implementation CMImageManager

+ (instancetype)manager {
    CMImageManager *manager = [[super alloc] init];
    return manager;
}

#pragma mark- 正确的方向的图像
- (UIImage *)fixOrientation {
    // 已经正确的方向
    if (self.image.imageOrientation == UIImageOrientationUp) {
        return  self.image;
    }
    
    // 如果方向不对, 我们要重新计算 旋转以及需要翻转的
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored: {
            // 向下方向, 顺时针旋转 180
            transform = CGAffineTransformTranslate(transform, self.image.size.width, self.image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored: {
            // 向右方向 顺时针旋转 -90
            transform = CGAffineTransformTranslate(transform, 0, self.image.size.height);
            transform = CGAffineTransformRotate(transform, - M_PI_2);
            break;
        }
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored: {
            // 方向向左 顺时针旋转 90, 矩阵变换
            transform = CGAffineTransformTranslate(transform,  self.image.size.width, 0);
            transform = CGAffineTransformRotate(transform,                                                                                                                                                                M_PI_2);
            break;
        }
        default:
            break;
    }
    
    // 翻转
    switch (self.image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored: {
            transform = CGAffineTransformTranslate(transform, self.image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: {
            transform = CGAffineTransformTranslate(transform, self.image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
        default:
            break;
    }
    
    // 创建图像环境
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.image.size.width, self.image.size.height,
                                             CGImageGetBitsPerComponent(self.image.CGImage), 0,
                                             CGImageGetColorSpace(self.image.CGImage),
                                             CGImageGetBitmapInfo(self.image.CGImage));
    // 串接矩阵
    CGContextConcatCTM(ctx, transform);
    switch (self.image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // 绘制图像
            CGContextDrawImage(ctx, CGRectMake(0,0,self.image.size.height,self.image.size.width), self.image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.image.size.width,self.image.size.height), self.image.CGImage);
            break;
    }
    
    // 创建新图像
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark- 正常的图像
- (UIImage *)normalizedImage {
    if (self.image.imageOrientation == UIImageOrientationUp) return self.image;
    
    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, self.image.scale);
    [self.image drawInRect:(CGRect){0, 0, self.image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

#pragma mark- 裁剪图像
- (UIImage *)resizeImageToSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self.image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

#pragma mark- 缩放图像
- (UIImage *)scaleImageToScale:(float)scale {
    
    UIGraphicsBeginImageContext(CGSizeMake(self.image.size.width * scale, self.image.size.height * scale));
    [self.image drawInRect:CGRectMake(0, 0, self.image.size.width * scale, self.image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}



@end
