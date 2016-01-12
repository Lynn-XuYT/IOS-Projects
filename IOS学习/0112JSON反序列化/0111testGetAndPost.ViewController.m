//
//  ViewController.m
//  0111testGetAndPost
//
//  Created by Lynn on 16/1/11.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Password.h"
#import "YTUser.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *logonResult;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)loginBtn;

@property(nonatomic, strong) NSString *myPWD;
@end

@implementation ViewController
- (NSString *)myPWD
{
    return [self.pwd.text myMD5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loginBtn {
    
    [self getLogin];
}

#pragma mark -GET登录
- (void)getLogin
{
    // URL
    //NSString *urlStr = [NSString stringWithFormat:@"http://192.0.4.1/loginGet.php?username=%@&password=%@&submit=login",self.username.text, self.myPWD];
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost/loginGet.php?username=%@&password=%@&submit=login",self.username.text, self.myPWD];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5.0f];
    
    // Connection

    // 创建Data Task
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"data = %@ , error = %@", data, error);
        if (error) {
            NSLog(@"%@=====%@", error.localizedDescription, [NSThread mainThread]);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络不给力" message:@"稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:act1];
                [self presentViewController:alert animated:YES completion:nil];
            }];
        }
        else if (error == nil) {
            // 网络请求结束之后执行
            // 将Data转换成NSString
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"str === %@",str);
            
            // 反序列化JSON
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",dict);
            YTUser *user = [[YTUser alloc] init];
            [user setValuesForKeysWithDictionary:dict];
            NSLog(@"%@",user);
            
            // 如果用户有头像
            if (user.userImage) {
                // 图像的数据
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.userImage ]];
                // 将数据转换成图像
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:data];
                    self.imageView.image = image;
                });
            }

#warning TODO
            if (!user.userId) {
                // 登录失败，在后台数据库没有该用户信息
                // 提示用户
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:act1];
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }else{
                // 更新界面
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    self.logonResult.text = str;
                }];
            }
        }

     }];
    // 使用resume方法启动任务
    [dataTask resume];
    NSLog(@"come here %@",[NSThread currentThread]);
}

@end
