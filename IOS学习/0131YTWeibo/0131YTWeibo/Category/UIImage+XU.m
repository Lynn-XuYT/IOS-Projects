//
//  UIImage+XU.m
//  0131YTWeibo
//
//  Created by Lynn on 16/1/31.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "UIImage+XU.h"

@implementation UIImage (XU)
+ (UIImage *)imageWithNamed:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        // 没有_os7后缀的图片
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    
    // 非iOS7
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizeImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height *0.5];
}
@end
