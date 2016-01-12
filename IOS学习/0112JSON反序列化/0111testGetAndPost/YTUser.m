//
//  YTUser.m
//  0111testGetAndPost
//
//  Created by Lynn on 16/1/12.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTUser.h"

@implementation YTUser

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ : %p> {userId : %@, user : %@, pwd : %@, userImage : %@}",[self class], self,self.userId ,self.user,self.pwd,self.userImage];
}
@end
