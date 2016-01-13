//
//  YTPerson.m
//  0113Copy
//
//  Created by Lynn on 16/1/13.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTPerson.h"

@implementation YTPerson

- (id)copyWithZone:(NSZone *)zone
{
    YTPerson *person = [[[self class] allocWithZone:zone]init];
    person.name = self.name;
    person.age = self.age;
    
    return person;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> name: %@, age: %d", [self class], self, self.name, self.age];
}
@end
