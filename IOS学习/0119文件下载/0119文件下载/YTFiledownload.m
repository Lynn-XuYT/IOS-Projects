//
//  YTFiledownload.m
//  0119文件下载
//
//  Created by Lynn on 16/1/19.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTFiledownload.h"
#import "NSString+Password.h"

#define kBytesPerTimes 1024

@interface YTFiledownload ()
@property(nonatomic, strong) NSString *cacheFile;
@property(nonatomic, assign) long long fileSize;
@property(nonatomic, strong) UIImage* cacheImage;
@end
@implementation YTFiledownload

- (UIImage *)cacheImage
{
    if (!_cacheImage) {
        _cacheImage = [UIImage imageWithContentsOfFile:self.cacheFile];
    }
    return _cacheImage;
}
//- (NSString *)cacheFile
//{
//    if (!_cacheFile) {
//        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//        _cacheFile = [cacheDir stringByAppendingPathComponent:@"kkk.mp4"];
//        NSLog(@"path====%@",_cacheFile);
//    }
//    return _cacheFile;
//}
- (void)setCacheFile:(NSString *)urlStr
{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];

    urlStr = [urlStr MD5];
    
    _cacheFile = [cacheDir stringByAppendingPathComponent:urlStr];
    
}
- (void)downloadFileWithURL:(NSURL *)url completion:(void(^)(UIImage *image))completion
{

    
    self.cacheFile = [url absoluteString];

    
    // 1.从网络下载文件，需要知道这个文件的大小
//    long long fileSize =
    [self fileSizeWithURL:url completion:^(UIImage *image) {
        self.cacheImage = image;
    }];

}

#pragma mark - 分段下载
- (void)filedownloadPartly:(NSURL *)url completion:(void(^)(UIImage *image))completion
{
//    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
//        <#statements#>
//    };
    // GCD中的串行队列异步方法
    dispatch_queue_t q = dispatch_queue_create("yt.lynn.download", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q, ^{
        NSLog(@"filedownloadPartly = %@",[NSThread currentThread]);
        // 计算本地缓存文件的大小
        long long cacheFlieSize = [self localFileSize];
        if (cacheFlieSize == self.fileSize) {
#warning 需要返回主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.cacheImage);
            });
            
            NSLog(@"文件已存在");
            return;
        }
        // 2 确定每个数据包的大小
        long long fromB = 0;
        long long toB = 0;
        // 计算起始和结束的字节数
        while (self.fileSize > kBytesPerTimes) {
            toB = fromB + kBytesPerTimes -1;
            
            // 分段下载文件
            [self downloadDataWithURL:url fromB:fromB toB:toB];
            
            self.fileSize -= kBytesPerTimes;
            
            fromB +=kBytesPerTimes;
        }
        [self downloadDataWithURL:url fromB:fromB toB:fromB +self.fileSize - 1];
#warning 回传
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(self.cacheImage);
        });
    });

}
#pragma mark - 下载指定字节范围的数据包
- (void)downloadDataWithURL:(NSURL *)url fromB:(long long)fromB toB:(long long)toB
{
    NSLog(@"downloadDataWithURL = %@",[NSThread currentThread]);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:1.0f];
    // 指定请求中所要GET的数据
    NSString *range = [NSString stringWithFormat:@"Bytes=%lld-%lld",fromB,toB];
    [request setValue:range forHTTPHeaderField:@"Range"];
//    NSLog(@"range = %@",range);
    NSURLResponse *response = nil;
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    // 写入文件 覆盖文件 不会追加
//    [data writeToFile:@"/Users/Lynn/Desktop/kk.mp4" atomically:YES];
    [self appendData:data];
    NSLog(@"respose = %@",response);
}

#pragma mark - 判断文件大小
- (long long)localFileSize
{
    // 读取本地字典信息
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:self.cacheFile error:NULL];
    
    NSLog(@"localFileSize =  %lld",[dict[NSFileSize] longLongValue]);
    return [dict[NSFileSize] longLongValue];
}

#pragma mark 追加数据到文件
- (void)appendData:(NSData *)data
{
    // 判断文件是否存在
    NSFileHandle *fp = [NSFileHandle fileHandleForWritingAtPath:self.cacheFile];
    // 如果文件不存在则创建文件
    if (!fp) {
        [data writeToFile:self.cacheFile atomically:YES];
    }else{
    // 如果存在则追加
        [fp seekToEndOfFile];
        // 追加
        [fp writeData:data];
        [fp closeFile];
    }
}

#pragma mark - 获取网络文件大小
- (void)fileSizeWithURL:(NSURL *)url completion:(void(^)(UIImage *image))completion
{
    // 默认是GET
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:1.0];
    // HEAD头，只是返回文件资源的信息，不返回具体数据
    // 如果要获取资源的MIMEType，也必须用HEAD，否则，数据会被重复下载两次
    request.HTTPMethod = @"HEAD";

    // 使用同步方法获取文件的大小
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // NSLog(@"%@",data);
            // expectedContentLength文件在网络上的大小
            //NSLog(@"expectedContentLength - %lld",response.expectedContentLength);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.fileSize = response.expectedContentLength;
                [self filedownloadPartly:url completion:^(UIImage *image) {
                    self.cacheImage = image;
                }];
        });
    }];
    [dataTask resume];
}
@end
