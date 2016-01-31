//
//  YTFiledownload.h
//  0119文件下载
//
//  Created by Lynn on 16/1/19.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YTFiledownload : NSObject

- (void)downloadFileWithURL:(NSURL *)url  completion:(void(^)(UIImage *image))completion;
@end
