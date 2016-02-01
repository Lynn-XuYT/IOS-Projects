//
//  XUTabBarButton.m
//  0131XUWeibo
//
//  Created by Lynn on 16/1/31.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUTabBarButton.h"
#import "XUBadgeButton.h"
// 按钮的默认文字颜色
#define XUTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])

// 按钮的选中文字颜色
#define XUTabBarButtonTitleSelectedColor (iOS7 ? [UIColor orangeColor] : XUColor(248, 139,0))


@interface XUTabBarButton ()

// 提醒数字按钮
@property(nonatomic, weak) XUBadgeButton *badgeButton;
@end
@implementation XUTabBarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:XUTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:XUTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        // 添加提醒数字按钮
        XUBadgeButton *badgeButton = [[XUBadgeButton alloc]init];
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}
/**
 *  监听到某个对象的属性改变了就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性改变了
 *  @param change  属性发生改变了
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
 
    // 设置frame
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width -10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;

}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}
- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
