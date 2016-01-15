//
//  ViewController.m
//  0115媒体播放器
//
//  Created by Lynn on 16/1/15.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "YTMovieViewController.h"
@interface ViewController ()<YTMovieViewControllerDelegate>
@property(nonatomic, strong) YTMovieViewController *movieViewController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController

- (YTMovieViewController *)movieViewController
{
    if (_movieViewController) {
        _movieViewController = [[YTMovieViewController alloc]init];
        _movieViewController.delegate = self;
        _movieViewController.movieURL = [NSURL URLWithString:@"http://localhost/testMovie.mp4"];
    }
    return _movieViewController;
}
- (IBAction)click
{
    [self presentViewController:self.movieViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YTMovieViewController *vc = segue.destinationViewController;
    vc.delegate = self;
    vc.movieURL = [NSURL URLWithString:@"http://localhost/testMovie.mp4"];
}
- (void)moviePlayerDidFinished:(YTMovieViewController *)movieViewController
{
    [movieViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)moviePlayerDidCapturedWithImage:(UIImage *)image
{
    self.imageView.image = image;
}
@end
